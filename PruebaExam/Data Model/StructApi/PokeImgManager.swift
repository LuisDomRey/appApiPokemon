//
//  PokeImgManager.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 15/02/23.
//

import Foundation

protocol PokemonImgManagerDelegate {
    func mostrarListaImg(Datos: Imagenes)
}

struct PokemonImgManager {
    
    //MARK: - Variables
    let urlPokemon = "https://pokeapi.co/api/v2"
    var delegate: PokemonImgManagerDelegate?
        
    //MARK: - EndPoints
    
    func endpointImagen(nombre: String){
        let urlString = "\(urlPokemon)/pokemon-form/\(nombre)"
        performRequestsImagenes(with: urlString)

    }
    
    func performRequestsImagenes(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                if let safeData = data {
                    if let datos = self.parseJsonImagenes(safeData){
                        self.delegate?.mostrarListaImg(Datos: datos)
                    }
                }
            }
            task.resume()
            
        }

    }
    


    
    
    
    //MARK: - ParseJSON
    
    func parseJsonImagenes(_ pokemonData: Data) -> Imagenes?{
        
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(Imagenes.self, from: pokemonData)
            
            return decodeData
        }catch{
            print(error)
            return nil
        }
        
    }

    
}
