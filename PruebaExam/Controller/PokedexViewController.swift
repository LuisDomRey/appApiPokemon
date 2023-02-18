//
//  ViewController.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 09/02/23.
//

import UIKit
import ChameleonFramework

class PokedexViewController: UIViewController, UITableViewDelegate{

    
    
    //MARK: - IBOulets
    @IBOutlet weak var searchBarPokedex: UISearchBar!
    @IBOutlet weak var tablaEspecie: UITableView!
    
    //MARK: - Variables
    var pokemonManager = PokemonManager()

    var datos: [PokemonData] = []
    var especiesFiltradas: [PokemonData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaEspecie.separatorStyle = .none
        
        //Registro de celda
        tablaEspecie.register(UINib(nibName: "CeldaEspecieViewTableCell", bundle: nil), forCellReuseIdentifier: "Celda")
        
        pokemonManager.delegate = self
        
        searchBarPokedex.delegate = self
        
        tablaEspecie.delegate = self
        tablaEspecie.dataSource = self
        
        pokemonManager.endpointEspeciePoke()

    }


    @IBAction func FavBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToFav", sender: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")}
        
        navBar.backgroundColor = UIColor(hexString: "555555")
        
        if let searchColor = UIColor(hexString: "C31415"){
            searchBarPokedex.barTintColor = searchColor
        }

    }
    
    
}
//MARK: - Search metodos
extension PokedexViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        especiesFiltradas = []
        
        if searchText == "" {
            especiesFiltradas = datos

        } else {
            for poke in datos {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    especiesFiltradas.append(poke)
                }
            }
        }

        self.tablaEspecie.reloadData()
    }
    
}

//MARK: - PokemonManagerDelegate
extension PokedexViewController: PokemonManagerDelegate {

    func mostrarListaEspecies(Datos: PokemonData) {
        DispatchQueue.main.async {
            self.datos.append(Datos)
            self.tablaEspecie.reloadData()
        }
        especiesFiltradas = datos
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - TableView delegate y Datasource
extension PokedexViewController: UITextViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return especiesFiltradas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaEspecie.dequeueReusableCell(withIdentifier: "Celda", for: indexPath) as! CeldaEspecieViewTableCell
        
        cell.tipoPoke.text = "Tipo: \(especiesFiltradas[indexPath.row].name)"
        cell.pokemonsCantidad.text = "Pokemons: \(especiesFiltradas[indexPath.row].pokemon_species.count)"
        
        cell.tintColor = UIColor(hexString: "FFFFFF")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPokemons", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToPokemons" {
            let destinationVC = segue.destination as! PokemonsViewController


            //se pasa el nombre de la categoria a la siguente vista
            if let indexPath = tablaEspecie.indexPathForSelectedRow{
                destinationVC.pokemons = especiesFiltradas[indexPath.row].pokemon_species
                destinationVC.tipo = especiesFiltradas[indexPath.row].name
            }

        }else {
            _ = segue.destination as! FavoritosViewController
        }


    }
    

    
}
