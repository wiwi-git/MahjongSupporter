//
//  UserData.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/25.
//

import UIKit

class UserData: NSObject {
    private override init() {
        super.init()
        self.insertNotificationObserver()
        
        let unitData = UnitData()
        var kanjiData = self.createUnits(type: .kanji, images: unitData.kanji19)
        kanjiData.sort { $0.id < $1.id }
        var bambooData = self.createUnits(type: .bamboo, images: unitData.bamboo19)
        bambooData.sort { $0.id < $1.id }
        var charData = self.createUnits(type: .char, images: unitData.character)
        charData.sort { $0.id < $1.id }
        var dotData = self.createUnits(type: .dot, images: unitData.dot19)
        dotData.sort { $0.id < $1.id }
        
        self.yourUnits[.bamboo] = bambooData
        self.yourUnits[.char] = charData
        self.yourUnits[.dot] = dotData
        self.yourUnits[.kanji] = kanjiData
    }
    static let shared = UserData()
    static let unitMaxCount:Int = 4
    
    var yourUnits:[UnitData.KeyType:[Unit]] = [:]
    
    var myUnit:[Unit] = [] {
        didSet{
            self.myUnit.sort { $0.id < $1.id }
            NotificationCenter.default.post(name: Notification.chageMyUnit, object: nil)
        }
    }
    
    var trashUnit:[Unit] = [] {
        didSet{
            NotificationCenter.default.post(name: Notification.chageTrashUnit, object: nil)
        }
    }
    
    private var usedUnit:[String:Int] = [:]
    
    func getUsedUnitCount(unit:Unit) -> Int? {
        if let value = self.usedUnit[unit.id] {
            return value
        }
        return nil
    }
    
    func addUsedUnit(unit:Unit) -> Bool {
        if let value = self.usedUnit[unit.id] {
            if (value + 1) < 4 {
                self.usedUnit[unit.id]! += 1;
                return true
            }
        } else {
            self.usedUnit[unit.id] = 1
            return true
        }
        return false
    }
    
    func insertNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.addUnitAction(_:)), name: Notification.addUnit, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.discardUnitAction(_:)), name: Notification.discardUnit, object: nil)
    }
    
    @objc func addUnitAction(_ notification:Notification) {
        print("addUnitAction:Notification")
        guard let userInfo = notification.userInfo,
              let unit = userInfo["unit"] as? Unit else {
            print("Error, addUnit not found ")
            return
        }
        self.myUnit.append(unit)
    }
    
    @objc func discardUnitAction(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let unit = userInfo["unit"] as? Unit else {
            print("Error, trash not found ")
            return
        }
        self.trashUnit.append(unit)
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
            case .dot:
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
            result.append(Unit(id: idSuffix + "-\(key.last!)", image: image, key: key))
        }
        return result
    }
    
}
