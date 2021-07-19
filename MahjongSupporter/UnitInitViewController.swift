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
    
    var kanjiData = [Unit]()
    var dotData = [Unit]()
    var bambooData = [Unit]()
    var charData = [Unit]()
    var collectionView:UICollectionView!
    
    enum Sections:Int,CaseIterable {
        case kanji = 0
        case dot
        case bamboo
        case char
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)))
        self.view.addSubview(selectedView)
        selectedView.snp.makeConstraints { m in
            m.top.leading.trailing.equalToSuperview()
            m.height.equalTo(100)
        }
        selectedView.layer.borderWidth = 1
        selectedView.layer.borderColor = UIColor.black.cgColor
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        self.collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 100)), collectionViewLayout: collectionViewLayout)
        self.collectionView.register(UINib(nibName: "UnitinitVCCell", bundle: nil), forCellWithReuseIdentifier: UnitInitVCCell.reuseId)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { m in
            m.top.equalTo(selectedView.snp.bottom)
            m.leading.trailing.equalToSuperview()
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        
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
        
        addAllUnit()
    }
    
    func addAllUnit() {
        let images = UnitData()
        let kanjiView = UIView()
        let bambooView = UIView()
        let dotView = UIView()
        let charView = UIView()
        
        self.kanjiData = self.createUnits(type: .kanji, images: images.kanji19)
        self.bambooData = self.createUnits(type: .bamboo, images: images.bamboo19)
        self.charData = self.createUnits(type: .char, images: images.character)
        self.dotData = self.createUnits(type: .dotKey, images: images.dot19)
        
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
                units[UnitData.CharacterKey.chuu.rawValue] = transImages[.chuu]
                units[UnitData.CharacterKey.east.rawValue] = transImages[.east]
                units[UnitData.CharacterKey.haku.rawValue] = transImages[.haku]
                units[UnitData.CharacterKey.hatsu.rawValue] = transImages[.hatsu]
                units[UnitData.CharacterKey.north.rawValue] = transImages[.north]
                units[UnitData.CharacterKey.south.rawValue] = transImages[.south]
                units[UnitData.CharacterKey.west.rawValue] = transImages[.west]
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
        for (i,key) in units.keys.enumerated() {
            let image = units[key]!
            result.append(Unit(id: idSuffix + "-\(i)", image: image, text: key))
        }
        
        return result
    }
    
    @objc func submitButtonAction() {
        
    }
    @objc func cancelButtonAction() {
        
    }

}
extension UnitInitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
        
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
            case .bamboo: return self.bambooData.count
            case .char: return self.charData.count
            case .dot: return self.dotData.count
            case .kanji: return self.kanjiData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
