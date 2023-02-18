//
//  PokemonsTableViewCell.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 11/02/23.
//

import UIKit

class PokemonsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var nombrePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
