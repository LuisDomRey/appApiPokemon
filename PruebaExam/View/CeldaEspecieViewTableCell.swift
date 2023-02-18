//
//  CeldaEspecieViewTableCell.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 10/02/23.
//

import UIKit

class CeldaEspecieViewTableCell: UITableViewCell {

    //MARK: - IBOulets
    @IBOutlet weak var tipoPoke: UILabel!
    @IBOutlet weak var pokemonsCantidad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
