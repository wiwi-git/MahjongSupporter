//
//  AddNewUnitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/24.
//

import UIKit

class AddNewUnitViewController: UIViewController {
    
    static let sbId = "sb_id_unitinit"
    
    var totalData = [Unit]()
    let maxCount = 15
    
    var kanjiData = [Unit]()
    var dotData = [Unit]()
    var bambooData = [Unit]()
    var charData = [Unit]()
    
    var collectionView:UICollectionView!
    let headerID = "AddNewUnitHeader"
    
    var alertVC:UIAlertController!
    
    enum Sections:Int,CaseIterable {
        case kanji = 0
        case dot
        case bamboo
        case char
    }// 만수패, 통수패, 삭수패, 자패 순
    
    var sectionTitles:[String] = [
        UnitData.SectionHeader[.kanji]!,
        UnitData.SectionHeader[.dotKey]!,
        UnitData.SectionHeader[.bamboo]!,
        UnitData.SectionHeader[.char]!
    ]// 만수패, 통수패, 삭수패, 자패 순
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewLayout = UICollectionViewFlowLayout()
        let unitWidth = self.view.frame.width / 10
        let unitHeight = unitWidth * 240 / 160
        collectionViewLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 50)
        collectionViewLayout.itemSize = CGSize(width: unitWidth, height: unitHeight)
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)), collectionViewLayout: collectionViewLayout)
        self.collectionView.register(UINib(nibName: UnitCell.identifier, bundle: nil), forCellWithReuseIdentifier: UnitCell.reuseId)
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.backgroundColor = .lightGray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { m in
            m.top.leading.trailing.equalToSuperview()
        }
        
        let bottomBar = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)))
        bottomBar.layer.borderColor = UIColor.black.cgColor
        bottomBar.layer.borderWidth = 1
        
        self.view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints { m in
            m.top.equalTo(self.collectionView.snp.bottom)
            m.leading.trailing.bottom.equalToSuperview()
            m.height.equalTo(40)
        }
        
        let submitButton = UIButton()
        let cancelButton = UIButton()
        let buttonWidth = CGFloat(100)
        submitButton.setTitle("완료", for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.black.cgColor
        
        submitButton.addTarget(self, action: #selector(self.submitButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelButtonAction), for: .touchUpInside)
        
        bottomBar.addSubview(submitButton)
        bottomBar.addSubview(cancelButton)
        
        submitButton.snp.makeConstraints { m in
            m.top.bottom.trailing.equalToSuperview()
            m.width.equalTo(buttonWidth)
        }
        cancelButton.snp.makeConstraints { m in
            m.top.bottom.equalToSuperview()
            m.trailing.equalTo(submitButton.snp.leading).offset(10)
            m.width.equalTo(buttonWidth)
        }
        
        self.alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        
        addAllUnit()
        self.collectionView.reloadData()
    }
    
    func addAllUnit() {
        let images = UnitData()
        
        self.kanjiData = self.createUnits(type: .kanji, images: images.kanji19)
        self.kanjiData.sort { $0.id < $1.id }
        self.bambooData = self.createUnits(type: .bamboo, images: images.bamboo19)
        self.bambooData.sort { $0.id < $1.id }
        self.charData = self.createUnits(type: .char, images: images.character)
        self.charData.sort { $0.id < $1.id }
        self.dotData = self.createUnits(type: .dotKey, images: images.dot19)
        self.dotData.sort { $0.id < $1.id }
        
    }
    
    func createUnits(type:UnitData.KeyType,images:Any) -> [Unit] {
        var result: [Unit] = []
        var units = [String:UIImage]()
        switch type {
            case .bamboo:
                let transImages = images as! [UnitData.BambooKey:UIImage]
                units[UnitData.BambooKey.bamboo1.rawValue] = transImages[.bamboo1]
                units[UnitData.BambooKey.bamboo2.rawValue] = transImages[.bamboo2]
                units[UnitData.BambooKey.bamboo3.rawValue] = transImages[.bamboo3]
                units[UnitData.BambooKey.bamboo4.rawValue] = transImages[.bamboo4]
                units[UnitData.BambooKey.bamboo5.rawValue] = transImages[.bamboo5]
                units[UnitData.BambooKey.bamboo6.rawValue] = transImages[.bamboo6]
                units[UnitData.BambooKey.bamboo7.rawValue] = transImages[.bamboo7]
                units[UnitData.BambooKey.bamboo8.rawValue] = transImages[.bamboo8]
                units[UnitData.BambooKey.bamboo9.rawValue] = transImages[.bamboo9]
            case .char:
                let transImages = images as! [UnitData.CharacterKey:UIImage]
                units[UnitData.CharacterKey.charChuu6.rawValue] = transImages[.charChuu6]
                units[UnitData.CharacterKey.charEast1.rawValue] = transImages[.charEast1]
                units[UnitData.CharacterKey.charHaku5.rawValue] = transImages[.charHaku5]
                units[UnitData.CharacterKey.charHatsu7.rawValue] = transImages[.charHatsu7]
                units[UnitData.CharacterKey.charNorth4.rawValue] = transImages[.charNorth4]
                units[UnitData.CharacterKey.charSouth3.rawValue] = transImages[.charSouth3]
                units[UnitData.CharacterKey.charWest2.rawValue] = transImages[.charWest2]
            case .dotKey:
                let transImages = images as! [UnitData.DotKey:UIImage]
                units[UnitData.DotKey.dot1.rawValue] = transImages[.dot1]
                units[UnitData.DotKey.dot2.rawValue] = transImages[.dot2]
                units[UnitData.DotKey.dot3.rawValue] = transImages[.dot3]
                units[UnitData.DotKey.dot4.rawValue] = transImages[.dot4]
                units[UnitData.DotKey.dot5.rawValue] = transImages[.dot5]
                units[UnitData.DotKey.dot6.rawValue] = transImages[.dot6]
                units[UnitData.DotKey.dot7.rawValue] = transImages[.dot7]
                units[UnitData.DotKey.dot8.rawValue] = transImages[.dot8]
                units[UnitData.DotKey.dot9.rawValue] = transImages[.dot9]
            case .kanji:
                let transImages = images as! [UnitData.KanjiKey:UIImage]
                units[UnitData.KanjiKey.kanji1.rawValue] = transImages[.kanji1]
                units[UnitData.KanjiKey.kanji2.rawValue] = transImages[.kanji2]
                units[UnitData.KanjiKey.kanji3.rawValue] = transImages[.kanji3]
                units[UnitData.KanjiKey.kanji4.rawValue] = transImages[.kanji4]
                units[UnitData.KanjiKey.kanji5.rawValue] = transImages[.kanji5]
                units[UnitData.KanjiKey.kanji6.rawValue] = transImages[.kanji6]
                units[UnitData.KanjiKey.kanji7.rawValue] = transImages[.kanji7]
                units[UnitData.KanjiKey.kanji8.rawValue] = transImages[.kanji8]
                units[UnitData.KanjiKey.kanji9.rawValue] = transImages[.kanji9]
        }
        
        guard let key = units.keys.first else {
            return []
        }
        
        let idSuffix = key[key.startIndex ..< key.index(key.startIndex, offsetBy: 3)]
        for key in units.keys {
            let image = units[key]!
            result.append(Unit(id: idSuffix + "-\(key.last!)", image: image, text: key))
        }
        return result
    }

    @objc func submitButtonAction() {
        if let selectedIndexArray = self.collectionView.indexPathsForSelectedItems {
            let indexPath = selectedIndexArray.first!
            guard let section = Sections(rawValue: indexPath.section) else {
                return
            }
            let unit:Unit
            switch section {
                case .bamboo:
                    unit = self.bambooData[indexPath.item]
                case .char:
                    unit = self.charData[indexPath.item]
                case .dot:
                    unit = self.dotData[indexPath.item]
                case .kanji:
                    unit = self.kanjiData[indexPath.item]
            }
            let userInfo = ["unit":unit]
            NotificationCenter.default.post(name: Notification.addUnit, object: nil, userInfo: userInfo)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "패를 선택하셔야합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func cancelButtonAction() {
        let alert = UIAlertController(title: nil, message: "패를 선택하지 않고 닫으시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension AddNewUnitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
            case .bamboo: return self.bambooData.count
            case .char: return self.charData.count
            case .dot: return self.dotData.count
            case .kanji: return self.kanjiData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitCell.reuseId, for: indexPath) as! UnitCell
        guard let section = Sections(rawValue: indexPath.section) else {
            return cell
        }
        let unit:Unit
        switch section {
            case .bamboo: unit = self.bambooData[indexPath.item]
            case .char: unit = self.charData[indexPath.item]
            case .dot: unit = self.dotData[indexPath.item]
            case .kanji: unit = self.kanjiData[indexPath.item]
        }
        cell.unitImageView.image = unit.image
        cell.unitData = unit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var v : UICollectionReusableView! = nil
        if kind == UICollectionView.elementKindSectionHeader {
            v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
            if v.subviews.count == 0 {
                v.addSubview(UILabel(frame:CGRect(x: 0,y: 0,width: collectionView.frame.width - 40, height: 50)))
            }
            let label = v.subviews[0] as! UILabel
            label.text = self.sectionTitles[indexPath.section]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        return v
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectCell = collectionView.cellForItem(at: indexPath),
           let selectUnit = selectCell as? UnitCell{
            selectUnit.darkView?.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectCell = collectionView.cellForItem(at: indexPath),
           let selectUnit = selectCell as? UnitCell{
            selectUnit.darkView?.isHidden = true
        }
    }
    
}
