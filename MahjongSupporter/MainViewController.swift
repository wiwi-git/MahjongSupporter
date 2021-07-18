//
//  MainViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/13.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    @IBOutlet weak var suggestView: UIView!
    @IBOutlet weak var trashRootStackView: UIStackView!
    @IBOutlet weak var line0TrashView: UIView!
    @IBOutlet weak var line1TrashView: UIView!
    @IBOutlet weak var myTrashStackView: UIStackView!
    
    var units:[Unit] = []
    var myUnitData:[Unit] = []
    var isEndInitUnit = false
    static var unitButtonSize = UnitButtonSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trashRootStackView.layer.borderWidth = 1
        self.trashRootStackView.layer.borderColor = UIColor.black.cgColor
        
        let initButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.myTrashStackView.frame.width, height: self.myTrashStackView.frame.height))
        
        initButton.setTitle("초기 설정을 해주세요.", for: .normal)
        initButton.layer.borderWidth = 1
        initButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(initButton)
    
        initButton.snp.makeConstraints { m in
            m.top.bottom.leading.trailing.equalTo(self.myTrashStackView)
        }
        self.view.bringSubviewToFront(initButton)
        
        initButton.addTarget(self, action: #selector(self.initButtonAction), for: .touchUpInside)
        initButton.backgroundColor = UIColor.gray

    }

    @objc func myTrashButtonAction(_ sender: UIButton) {
        
    }
    
    @objc func initButtonAction() {
        let frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        
    }
    
}

