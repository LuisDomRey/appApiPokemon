//
//  FavoritosViewController.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 10/02/23.
//

import UIKit
import RealmSwift
import SwipeCellKit

class FavoritosViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tablaFavoritos: UITableView!
    
    //MARK: - Variables para data O realm
    let realm = try! Realm()
    var pokemons: Results<Pokemon>?
    var pokemon = Pokemon()
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarPokemons()
        
        tablaFavoritos.delegate = self
        tablaFavoritos.dataSource = self
        tablaFavoritos.rowHeight = 70.0


    }
    
    //MARK: - Metodos de manipulacion de datos
    func cargarPokemons(){
        
        pokemons = realm.objects(Pokemon.self)
        tablaFavoritos.reloadData()
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
    
}


//MARK: - TableView Delegate y DataSource
extension FavoritosViewController: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaFavoritos.dequeueReusableCell(withIdentifier:  "Cell", for: indexPath) as!
        SwipeTableViewCell
        
        cell.delegate = self
        cell.tintColor = UIColor(hexString: "FFFFFF")
        cell.textLabel?.text = pokemons?[indexPath.row].name
        cell.backgroundColor = UIColor(hexString: cargarColor(tipo: pokemons?[indexPath.row].type ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.updateModel(at: indexPath)
            
        }
        
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
        //MARK: - Delete Data From Swipe
    
    func updateModel(at indexPath: IndexPath) {
    
            if let pokemonForDeletion = self.pokemons?[indexPath.row]{
                do{
                    try self.realm.write {
                        self.realm.delete(pokemonForDeletion)
                    }
                }catch{
                    print("Error deleting category, \(error)")
                }
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailFav", sender: self)
        
        pokemon.id = pokemons?[indexPath.row].id ?? 0
        pokemon.name = pokemons?[indexPath.row].name ?? ""
        pokemon.type = pokemons?[indexPath.row].type ?? ""
        pokemon.imageUrl = pokemons?[indexPath.row].imageUrl ?? ""
        pokemon.attack = pokemons?[indexPath.row].attack ?? 0
        pokemon.defense = pokemons?[indexPath.row].defense ?? 0
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.pokemonCargado = pokemon
    }
    

}
