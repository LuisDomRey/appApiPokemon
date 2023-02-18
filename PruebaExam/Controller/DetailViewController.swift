//
//  DetailViewController.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 10/02/23.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    //MARK: - IBoutlets
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var nombrePokemon: UILabel!
    
    @IBOutlet var fondo: UIView!
    @IBOutlet weak var statusDef: UILabel!
    @IBOutlet weak var statusAtaque: UILabel!
    @IBOutlet weak var ataqueBar: UIProgressView!
    @IBOutlet weak var defBar: UIProgressView!
    
    @IBOutlet weak var numPokemon: UILabel!
    @IBOutlet weak var tipoPokemon: UILabel!
    
    //CoreData o Real
    let realm = try! Realm()
    var pokemonCargado: Pokemon?
    
    
    //MARK: - Variables
    var detallePokemon: ApiExterna?
    var nombre: String?
    var imagenPoke: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarDatos()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")}
        
        navBar.backgroundColor = UIColor(hexString: "555555")

    }
    
    //MARK: - Metodos para mostrar datos desde api
    func cargarColor(tipo: String) -> String{
        switch tipo {
        case "poison":
            return "9437FF"
        case "fire":
            return "FF9300"
        case "water":
            return "0096FF"
        case "bug":
            return "4D8F9C"
        case "flying":
            return "B1FDFF"
        case "electric":
            return "FFFB00"
        case "ground":
            return "AA7942"
        case "fairy":
            return "C4FDC7"
        case "grass":
            return "008F00"
        case "fighting":
            return "A3E6D8"
        case "psychic":
            return "D783FF"
        case "steel":
            return "5D7FA0"
        case "ice":
            return "73FDFF"
        case "rock":
            return "5E5E5E"
        case "dragon":
            return "D4FB79"
        default:
            return "D6D6D6"
        }
    }
    
    func cargarDatos(){
        
        if pokemonCargado?.id != nil && pokemonCargado?.name != nil && pokemonCargado?.type != nil && pokemonCargado?.imageUrl != nil && pokemonCargado?.attack != nil && pokemonCargado?.defense != nil {
            
             cargarPokemonGuardado()
            imagenPoke = pokemonCargado?.imageUrl
            
        } else {
            imagenPoke = detallePokemon?.imageUrl

            
            nombre = detallePokemon?.name.uppercased()
            nombrePokemon.text = "Nombre: \(nombre ?? "")"
            fondo.backgroundColor = UIColor(hexString: cargarColor(tipo: detallePokemon?.type ?? ""))
            tipoPokemon.text = "Tipo: \(detallePokemon?.type ?? "")"
            numPokemon.text = "N°: \(detallePokemon?.id ?? 0)"
            
            ataqueBar.progress = Float(detallePokemon?.attack ?? 0) / Float(100)
            defBar.progress = Float(detallePokemon?.defense ?? 0) / Float(100)
            
            statusAtaque.text = "\(detallePokemon?.attack ?? 0)"
            statusDef.text = "\(detallePokemon?.defense ?? 0)"
        }
        
        
        if let urlString = imagenPoke{
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imagenURL) else {return}
                    let imagen = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.imagenPokemon.image = imagen
                    }
                    
                }
            }
        }
        

        
    }
    
    //MARK: - Metodos de Manipulacion de Datos
    func guardar(pokemon: Pokemon){
        do{
            try realm.write{
                realm.add(pokemon)
            }
        }catch{
            print("Error al guardar Pokemon \(error)")
        }
        
    }
    
    //MARK: - Metodos de manipulacion de datos
    func cargarPokemonGuardado(){
        
        nombrePokemon.text = "Nombre: \(pokemonCargado?.name ?? "")"
        fondo.backgroundColor = UIColor(hexString: cargarColor(tipo: pokemonCargado?.type ?? ""))
        tipoPokemon.text = "Tipo: \(pokemonCargado?.type ?? "")"
        numPokemon.text = "N°: \(pokemonCargado?.id ?? 0)"
        
        ataqueBar.progress = Float(pokemonCargado?.attack ?? 0) / Float(100)
        defBar.progress = Float(pokemonCargado?.defense ?? 0) / Float(100)
        
        statusAtaque.text = "\(pokemonCargado?.attack ?? 0)"
        
        
        
        
    }
    

    @IBAction func selShiny(_ sender: UISwitch) {
    }
    
    @IBAction func agregarBtn(_ sender: UIButton) {
        
        let pokemonAsSave = Pokemon()
        pokemonAsSave.name = detallePokemon?.name ?? ""
        pokemonAsSave.type = detallePokemon?.type ?? ""
        pokemonAsSave.id = detallePokemon?.id ?? 0
        pokemonAsSave.defense = detallePokemon?.defense ?? 0
        pokemonAsSave.attack = detallePokemon?.attack ?? 0
        pokemonAsSave.imageUrl = detallePokemon?.imageUrl ?? ""
        
        self.guardar(pokemon: pokemonAsSave)
        print("Pokemon guardado: \(detallePokemon?.name ?? "")")
    }
    

}
