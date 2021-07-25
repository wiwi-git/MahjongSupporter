//
//  TrashViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/25.
//

import UIKit

class TrashViewController: UIViewController {
    var collectionView: UICollectionView!
    let userData = UserData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.chageTrashUnit(_:)), name: Notification.chageTrashUnit, object: nil)
        
        let unitWidth = self.view.frame.width / 15 // 3 3 3 3 2 = 14
        let unitHeight = unitWidth * 240 / 160
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: unitWidth, height: unitHeight)
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: self.view.frame.size), collectionViewLayout: layout)
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: UnitCell.identifier, bundle: nil), forCellWithReuseIdentifier: UnitCell.reuseId)
        
        self.collectionView.snp.makeConstraints { m in
            m.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    @objc func chageTrashUnit(_ notification:Notification) {
        self.collectionView.reloadData()
    }
}
extension TrashViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userData.trashUnit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitCell.reuseId, for: indexPath) as! UnitCell
        let item = self.userData.trashUnit[indexPath.item]
        cell.unitImageView.image = item.image
        cell.unitData = item
        return cell
    }
}
