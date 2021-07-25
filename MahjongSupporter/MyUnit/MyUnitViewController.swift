//
//  MyUnitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/24.
//

import UIKit
import SnapKit

class MyUnitViewController: UIViewController {
    var collectionView: UICollectionView!
    var unitCountLabel = UILabel()
    let userData = UserData.shared
    let addUnitVC = AddNewUnitViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.chageMyUnit), name: Notification.chageMyUnit, object: nil)
        let unitWidth = self.view.frame.width / 15 // 3 3 3 3 2 = 14
        let unitHeight = unitWidth * 240 / 160
        
        /// stateBar
        let stateBarView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 30)))
        let unitCountGuideLabel = UILabel()
        unitCountGuideLabel.text = "Count: "
        self.unitCountLabel.text = "0"
        unitCountGuideLabel.sizeToFit()
        
        stateBarView.addSubview(unitCountGuideLabel)
        stateBarView.addSubview(self.unitCountLabel)
        self.view.addSubview(stateBarView)
        
        stateBarView.snp.makeConstraints { m in
            m.top.leading.trailing.equalToSuperview()
            m.height.equalTo(unitCountGuideLabel.frame.height + 4)
        }
        
        self.unitCountLabel.snp.makeConstraints { m in
            m.top.bottom.equalToSuperview()
            m.trailing.equalToSuperview().offset(-8)
        }
        unitCountGuideLabel.snp.makeConstraints { m in
            m.top.bottom.equalToSuperview()
            m.trailing.equalTo(self.unitCountLabel.snp.leading)
        }
        
        
        //MyUnit ColletionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: unitWidth, height: unitHeight)
        
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: self.view.frame.size), collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: UnitCell.identifier, bundle: nil), forCellWithReuseIdentifier: UnitCell.reuseId)
        
        self.collectionView.snp.makeConstraints { m in
            m.top.equalTo(stateBarView.snp.bottom)
            m.leading.trailing.equalToSuperview()
        }
        
        // addButton
        let addButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 50)))
        addButton.setTitle("내 패 추가", for: .normal)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        addButton.snp.makeConstraints { m in
            m.top.equalTo(self.collectionView.snp.bottom)
            m.bottom.leading.trailing.equalToSuperview()
            m.height.equalTo(unitWidth)
        }
    }
    
    @objc func chageMyUnit(){
        self.unitCountLabel.text = "\(self.userData.myUnit.count)"
        self.collectionView.reloadData()
    }
    
    @objc func addButtonAction() {
        self.addUnitVC.view.frame = CGRect(origin: .zero, size: self.view.frame.size)
        self.addUnitVC.view.backgroundColor = .white
        self.addUnitVC.postTarget = .My
        self.present(self.addUnitVC, animated: true, completion: nil)
    }
    
}
extension MyUnitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userData.myUnit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitCell.reuseId, for: indexPath) as! UnitCell
        let item = self.self.userData.myUnit[indexPath.item]
        cell.unitImageView.image = item.image
        cell.unitData = item
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "이 패를 버리겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            let item = self.userData.myUnit.remove(at: indexPath.item)
            let userInfo = ["unit":item]
            NotificationCenter.default.post(name: Notification.discardUnit, object: nil, userInfo: userInfo)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
