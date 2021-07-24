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
    @IBOutlet weak var myUnitAreaView: UIView!
    @IBOutlet weak var myTrashUnitAreaView: UIView!
    @IBOutlet weak var mySelectUnitAreaView: UIView!
    
    var myUnitVC = MyUnitViewController()
    
    var myUnitData:[Unit] = []
    var isEndInitUnit = false
    static var unitSize = CGSize(width: UnitButtonSize().width, height: UnitButtonSize().height)//UnitButtonSize()
    
//    var myUnits = [Unit]() {
//        didSet{
//            self.myUnits.sort { $0.id < $1.id }
//            self.myUnitVC.myUnit = self.myUnits
//        }
//    }
//
    var initButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(completUnitInitAction(_:)), name: Notification.completUnitInit, object: nil)
        
        self.myUnitAreaView.layer.borderWidth = 1
        self.myUnitAreaView.layer.borderColor = UIColor.black.cgColor
        
        self.addChild(self.myUnitVC)

        self.myUnitVC.view.frame = CGRect(origin: .zero, size: self.mySelectUnitAreaView.frame.size)
        
        self.mySelectUnitAreaView.addSubview(self.myUnitVC.view)
        self.myUnitVC.view.snp.makeConstraints { m in
            m.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.initButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.myUnitAreaView.frame.width, height: self.myUnitAreaView.frame.height))
        
        self.initButton.setTitle("초기 설정을 해주세요.", for: .normal)
        self.initButton.layer.borderWidth = 1
        self.initButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(self.initButton)
    
        self.initButton.snp.makeConstraints { m in
            m.top.bottom.leading.trailing.equalTo(self.myUnitAreaView)
        }
        self.view.bringSubviewToFront(self.initButton)
//        self.initButton.isHidden = true
        
        self.initButton.addTarget(self, action: #selector(self.initButtonAction), for: .touchUpInside)
        self.initButton.backgroundColor = UIColor.gray
    }
    
    @objc func completUnitInitAction(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let units = userInfo["units"] as? [Unit] else {
            return
        }
    
        self.initButton.isHidden = true
//        self.myUnits = units
        self.myUnitVC.myUnit = units
    }

    @objc func myTrashButtonAction(_ sender: UIButton) {
        
    }
    
    @objc func initButtonAction() {
        let vc = UnitInitViewController()
        vc.view.frame = CGRect(origin: .zero, size: self.view.frame.size)
        vc.view.backgroundColor = .white
        self.present(vc, animated: true, completion: nil)
    }
}

extension Notification {
    static let completUnitInit = Notification.Name(rawValue: "notification_complet_unit_init")
}

