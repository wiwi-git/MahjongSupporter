//
//  UnitButton.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/16.
//

import UIKit

class UnitButton: UIButton {
    var unitData:Unit = Unit(id: "0", image: UIImage(), text: "")
    
    init() {
        fatalError("init() has not been implemented")
    }
    
    init(frame: CGRect, unit:Unit) {
        super.init(frame: frame)
        self.unitData = unit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
