//
//  PokemonApi2Manager.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 14/02/23.
//

import Foundation


protocol PokemonApi2ManagerDelegate {
    func mostrarListaPokemon(Datos: [ApiExterna])
    func didFailWithError(error: Error)
}

struct PokemonApi2Manager {
    
    //MARK: - Variables
    var delegate: PokemonApi2ManagerDelegate?
        
    
    func performRequest(){
        let urlApi2 = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlApi2) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data?.quitarNull(quitarNull: "null,"){
                    if let datos = self.parseJsonDatosApi2(safeData){
                        self.delegate?.mostrarListaPokemon(Datos: datos)
                    }
                }
                
            }
            task.resume()
        }
    }

    
    
    //MARK: - ParseJSON
    func parseJsonDatosApi2(_ pokemonData: Data) -> [ApiExterna]?{
        
        let decoder = JSONDecoder()
        do{
//                        let dataRaw = String(data: pokemonData, encoding: .utf8) ?? ""
//                        print(dataRaw)
            let decodeData = try decoder.decode([ApiExterna].self, from: pokemonData)
            
            return decodeData
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    

    
}

extension Data {
    
    func quitarNull(quitarNull palabra: String) -> Data?{
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
        
    }
}








