//
//  PokemonsViewController.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 10/02/23.
//

import UIKit

class PokemonsViewController: UIViewController, UITableViewDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tablaPokemons: UITableView!
    
    //MARK: - Variables
    var pokemonApi2Manager = PokemonApi2Manager()
    
    var pokemons: [Pokemon_Species] = []
    var tipo: String?
    
    var pokemonsFiltrados: [Pokemon_Species] = []
    var datosApi2: [ApiExterna] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaPokemons.register(UINib(nibName: "PokemonsTableViewCell", bundle: nil), forCellReuseIdentifier: "CeldaPoke")
        
        pokemonApi2Manager.delegate = self
        
        searchBar.delegate = self
        
        tablaPokemons.delegate = self
        tablaPokemons.dataSource = self
        
        pokemonApi2Manager.performRequest()
        pokemonsFiltrados = pokemons
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")}
        
        navBar.backgroundColor = UIColor(hexString: "555555")
        
        
    }
}

//MARK: - Search Metodos
extension PokemonsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonsFiltrados = []
        
        if searchText == "" {
            pokemonsFiltrados = pokemons
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    pokemonsFiltrados.append(poke)
                }
            }
        }
        self.tablaPokemons.reloadData()
    }
}


//MARK: - PokemonApi2ManagerDelegate
extension PokemonsViewController: PokemonApi2ManagerDelegate {
    func mostrarListaPokemon(Datos: [ApiExterna]) {

        DispatchQueue.main.async {
            self.datosApi2 = Datos
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: - TableViewDelegate, TableViewDataSource

extension PokemonsViewController: UITextViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaPoke", for: indexPath) as! PokemonsTableViewCell
        
        cell.nombrePokemon.text = pokemonsFiltrados[indexPath.row].name
        cell.tipoPokemon.text = tipo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        //se pasa el nombre de la categoria a la siguente vista
        if let indexPath = tablaPokemons.indexPathForSelectedRow{
            
            destinationVC.detallePokemon = enviarDetallePokemon(pokemonSeleccionado: pokemonsFiltrados[indexPath.row].name,tamaño: datosApi2.count)
            
        }
    }
    
    
    func enviarDetallePokemon(pokemonSeleccionado: String, tamaño: Int) -> ApiExterna?{
        
        var pokemonSel: ApiExterna?
        var index: Int = 0
        var bandera: Bool = false
        
        while index < tamaño && !bandera {
            if pokemonSeleccionado == datosApi2[index].name {
                pokemonSel = datosApi2[index]
                bandera = true
            }else {
                index += 1
            }
        }
        
        return pokemonSel
        
    }
    
    
}
