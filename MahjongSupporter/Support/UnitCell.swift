//
//  UnitInitVCCell.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/19.
//

import UIKit

class UnitCell: UICollectionViewCell {
    static let reuseId = "cell_id_unitinitvccell"
    
    class var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var unitImageView: UIImageView!
    
    var unitData:Unit?
    var darkView:UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor(red: 47/255, green: 131/255, blue: 47/255, alpha: 1).cgColor
        self.darkView = UIView(frame: CGRect(origin: .zero, size: self.frame.size))
        self.darkView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addSubview(darkView!)
        
        darkView?.snp.makeConstraints({ m in
            m.top.bottom.leading.trailing.equalToSuperview()
        })
        
        self.darkView?.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.unitData = nil
        self.unitImageView.image = nil
    }
}
