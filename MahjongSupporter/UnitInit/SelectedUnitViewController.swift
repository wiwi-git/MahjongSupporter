//
//  SelectedUnitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/21.
//

import UIKit

class SelectedUnitViewController: UIViewController {
    var calledVc: UIViewController?
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
        
        self.collectionView.register(UINib(nibName: UnitCell.identifier, bundle: nil), forCellWithReuseIdentifier: UnitCell.reuseId)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitCell.reuseId, for: indexPath) as! UnitCell
        let item = self.selectedUnit[indexPath.item]
        cell.unitData = item
        cell.unitImageView.image = item.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UnitCell
        cell.darkView?.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UnitCell
        cell.darkView?.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let unit = self.selectedUnit[indexPath.item]
        (self.calledVc as? UnitInitViewController)?
            .showAlert(title: nil, message: "이 패를 버리시겠습니까?", actions:
                        [
                            UIAlertAction(title: "Yes", style: .default, handler: { _ in
                                collectionView.deleteItems(at: [indexPath])
                                if self.selectedUnit[indexPath.item].id == unit.id {
                                    self.selectedUnit.remove(at: indexPath.item)
                                }
                            }),
                            UIAlertAction(title: "No", style: .cancel, handler: nil)
                        ]
            )
    }
    
}
