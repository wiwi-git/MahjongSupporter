//
//  UserData.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/25.
//

import Foundation

class UserData: NSObject {
    private override init() {
        super.init()
        self.insertNotificationObserver()
        
    }
    static let shared = UserData()
    
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
    
    
    
    
}
