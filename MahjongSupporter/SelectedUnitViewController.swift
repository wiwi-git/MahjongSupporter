//
//  SelectedUnitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/21.
//

import UIKit

class SelectedUnitViewController: UIViewController,
                                  UICollectionViewDelegate,
                                  UICollectionViewDataSource {
    var collectionView:UICollectionView!
    
    var selectedUnit = [Unit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.register(UINib(nibName: "UnitInitVCCell", bundle: nil), forCellWithReuseIdentifier: UnitInitVCCell.reuseId)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedUnit.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitInitVCCell.reuseId, for: indexPath) as! UnitInitVCCell
        let item = selectedUnit[indexPath.item]
        cell.unitData = item
        cell.unitImageView.image = item.image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
