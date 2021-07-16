//
//  UnitInitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/16.
//

import UIKit
import SnapKit

class UnitInitViewController: UIViewController {

    var totalData = [Unit]()
    var selectedUnit : [Unit] = []
    let maxCount = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)))
        self.view.addSubview(selectedView)
        selectedView.snp.makeConstraints { m in
            m.top.leading.trailing.equalTo(self.view)
            m.height.equalTo(100)
        }
        
        let scrollView = UIScrollView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { m in
            m.top.equalTo(selectedView.snp.bottom)
            m.leading.trailing.equalTo(self.view)
        }
        
        let bottomBar = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)))
        bottomBar.backgroundColor = .lightGray
        self.view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints { m in
            m.top.equalTo(scrollView.snp.bottom)
            m.leading.trailing.bottom.equalTo(self.view)
        }
        
        let submitButton = UIButton()
        let cancelButton = UIButton()
        
        submitButton.setTitle("완료", for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        submitButton.addTarget(self, action: #selector(self.submitButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelButtonAction), for: .touchUpInside)
        
        bottomBar.addSubview(submitButton)
        bottomBar.addSubview(cancelButton)
    }
    
    @objc func submitButtonAction() {
        
    }
    @objc func cancelButtonAction() {
        
    }

}
