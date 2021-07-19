//
//  UnitInitVCCell.swift
//  MahjongSupporter
//
//  Created by Emoticbox on 2021/07/19.
//

import UIKit

class UnitInitVCCell: UICollectionViewCell {
    static let reuseId = "cell_id_unitinitvccell"
    @IBOutlet weak var imageView:UIImageView!
    
    var unitData:Unit?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.unitData = nil
    }

}
