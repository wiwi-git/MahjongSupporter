//
//  SelectedUnitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/21.
//

import UIKit

class SelectedUnitViewController: UIViewController {
    var collectionView:UICollectionView!
    var selectedUnit = [Unit]() {
        didSet{
            self.collectionView.insertItems(at: [IndexPath(item: self.selectedUnit.count - 1, section: 0)])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: self.view.frame.size), collectionViewLayout: layout)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { m in
            m.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.collectionView.register(UINib(nibName: "UnitInitVCCell", bundle: nil), forCellWithReuseIdentifier: UnitInitVCCell.reuseId)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .lightGray
    }
}
extension SelectedUnitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedUnit.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemat")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitInitVCCell.reuseId, for: indexPath) as! UnitInitVCCell
        let item = self.selectedUnit[indexPath.item]
        cell.unitData = item
        cell.unitImageView.image = item.image
        return cell
    }
    
}