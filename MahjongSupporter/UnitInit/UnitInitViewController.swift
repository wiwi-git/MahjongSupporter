//
//  UnitInitViewController.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/16.
//

import UIKit

class UnitInitViewController: UIViewController {
    static let sbId = "sb_id_unitinit"
    
    var totalData = [Unit]()
    let maxCount = 14
    
    var kanjiData = [Unit]()
    var dotData = [Unit]()
    var bambooData = [Unit]()
    var charData = [Unit]()

    var collectionView:UICollectionView!
    let headerID = "UnitInitHeader"
    
    let selectedUnitVC = SelectedUnitViewController()

    
    var alertVC:UIAlertController!
    
    enum Sections:Int,CaseIterable {
        case kanji = 0
        case dot
        case bamboo
        case char
    }
    
    var sectionTitles:[String] = [
        UnitData.SectionHeader[.kanji]!,
        UnitData.SectionHeader[.dot]!,
        UnitData.SectionHeader[.bamboo]!,
        UnitData.SectionHeader[.char]!
    ]// 만수패, 통수패, 삭수패, 자패 순
    
    
    
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
        
        
        self.addChild(self.selectedUnitVC)
        self.selectedUnitVC.view.frame = CGRect(origin: .zero, size: selectedView.frame.size)
        selectedView.addSubview(self.selectedUnitVC.view)
        
        self.selectedUnitVC.view.snp.makeConstraints { m in
            m.top.leading.trailing.bottom.equalToSuperview()
        }
        self.selectedUnitVC.didMove(toParent: self)
        self.selectedUnitVC.calledVc = self
        
        
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
            m.top.equalTo(selectedView.snp.bottom)
            m.leading.trailing.equalToSuperview()
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
        let userData = UserData.shared
        self.kanjiData = userData.yourUnits[.kanji]!
        self.bambooData = userData.yourUnits[.bamboo]!
        self.charData = userData.yourUnits[.char]!
        self.dotData = userData.yourUnits[.dot]!
    }
    
    func showAlert(title:String?,message:String?,actions:[UIAlertAction] = [UIAlertAction(title: "ok", style: .cancel, handler: nil)]) {
        self.alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            self.alertVC.addAction(action)
        }
        self.present(self.alertVC, animated: true, completion: nil)
    }
    
    @objc func submitButtonAction() {
        if self.selectedUnitVC.selectedUnit.count < self.maxCount {
            self.showAlert(title: nil, message: "패는 \(self.maxCount)장 선택되어야 합니다.")
            return
        }
        
        for unit in self.selectedUnitVC.selectedUnit {
            if let key = UnitData.BambooKey(rawValue: unit.key) {
                let addResult = UserData.shared.addUsedUnit(unit: unit)
                if addResult, UserData.shared.getUsedUnitCount(unit: unit)! == UserData.unitMaxCount {
                    let before = UserData.shared.yourUnits[.bamboo]!
                    let after = before.filter { item in
                        item.id != unit.id
                    }
                    UserData.shared.yourUnits[.bamboo] = after
                } else {
                    print("Error, 책갈피-")
                }
                return
            }
            if let key = UnitData.CharacterKey(rawValue: unit.key) {
                
                return
            }
            if let key = UnitData.DotKey(rawValue: unit.key) {
                
                return
            }
            if let key = UnitData.KanjiKey(rawValue: unit.key) {
                
            }
        }
        
        UserData.shared.myUnit = self.selectedUnitVC.selectedUnit

        NotificationCenter.default.post(name: Notification.completUnitInit, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonAction() {
        self.showAlert(title: nil, message: "초기패 선택창을 닫으시겠습니까?",actions: [
            UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }),
            UIAlertAction(title: "No", style: .cancel, handler: nil)
        ])
    }
    
}
extension UnitInitViewController: UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UnitCell
        cell.layer.borderWidth = 2
        cell.darkView?.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UnitCell
        cell.layer.borderWidth = 0
        cell.darkView?.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelect \(indexPath)")
        guard let section = Sections(rawValue: indexPath.section) else {
            return
        }
        let unit:Unit
        switch section {
            case .bamboo: unit = self.bambooData[indexPath.item]
            case .char: unit = self.charData[indexPath.item]
            case .dot: unit = self.dotData[indexPath.item]
            case .kanji: unit = self.kanjiData[indexPath.item]
        }
        
        guard self.selectedUnitVC.selectedUnit.count < self.maxCount else {
            self.showAlert(title: nil, message: "가질 수 있는 패의 최대 갯수는 \(self.maxCount)장 입니다.\n추가를 하시려면 기존 추가한 패를 버려주세요.")
            return
        }
        let filtered = self.selectedUnitVC.selectedUnit.filter { saved in
            return saved.id == unit.id
        }
        if filtered.count < 4 {
            self.selectedUnitVC.selectedUnit.append(unit)
        } else {
            self.showAlert(title: nil, message: "같은 패는 4개를 초과할 수 없습니다.")
        }
    }
    
}
