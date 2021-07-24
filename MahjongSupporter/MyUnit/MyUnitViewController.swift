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
    var myUnit = [Unit]() {
        didSet{
            print("myUnit didset")
            self.myUnit.sort { $0.id < $1.id }
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let unitWidth = self.view.frame.width / 15 // 3 3 3 3 2 = 14
        let unitHeight = unitWidth * 240 / 160
        
        let addButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 50)))
        addButton.setTitle("ADD", for: .normal)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        addButton.snp.makeConstraints { m in
            m.top.leading.trailing.equalToSuperview()
            m.height.equalTo(unitWidth)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: unitWidth, height: unitHeight)
        
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: self.view.frame.size), collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: UnitCell.identifier, bundle: nil), forCellWithReuseIdentifier: UnitCell.reuseId)
        
        self.collectionView.snp.makeConstraints { m in
            m.top.equalTo(addButton.snp.bottom)
            m.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func addButtonAction() {
        let vc = AddNewUnitViewController()
        vc.view.frame = CGRect(origin: .zero, size: self.view.frame.size)
        self.present(vc, animated: true, completion: nil)
    }
}
extension MyUnitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("MyUnit noiis count \(self.myUnit.count)")
        return self.myUnit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitCell.reuseId, for: indexPath) as! UnitCell
        let item = self.myUnit[indexPath.item]
        cell.unitImageView.image = item.image
        cell.unitData = item
        return cell
    }
    
}
