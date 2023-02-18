//
//  PokemonManager.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 09/02/23.
//

import Foundation

protocol PokemonManagerDelegate {
    func mostrarListaEspecies(Datos: PokemonData)
    func didFailWithError(error: Error)
}

struct PokemonManager {
    
    //MARK: - Variables
    let urlPokemon = "https://pokeapi.co/api/v2"
    var urlImagen: String?
    var delegate: PokemonManagerDelegate?

        
    //MARK: - EndPoints
    func endpointEspeciePoke(){
        let urlString = "\(urlPokemon)/egg-group"
        for index in 1...15 {
            performRequests(with: "\(urlString)/\(index)")
        }
    }


    func performRequests(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let datos = self.parseJsonDatos(safeData){
                        self.delegate?.mostrarListaEspecies(Datos: datos)
                        
                    }
                }
            }
            task.resume()
            
        }
    }
    
    
    
    //MARK: - ParseJSON
    
    func parseJsonDatos(_ pokemonData: Data) -> PokemonData?{
        
        let decoder = JSONDecoder()
        do{
//            let dataRaw = String(data: pokemonData, encoding: .utf8) ?? ""
//            print(dataRaw)
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            return decodeData
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    

    
}
