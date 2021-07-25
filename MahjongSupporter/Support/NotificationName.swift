//
//  NotificationName.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/25.
//

import Foundation

extension Notification {
    static let completUnitInit = Notification.Name(rawValue: "notification_complet_unit_init")
    static let addUnit = Notification.Name("notification_add_unit")
    static let discardUnit = Notification.Name("notification_discard_unit")
    static let chageMyUnit = Notification.Name("notification_chage_my_unit")
    static let chageTrashUnit = Notification.Name("notification_chage_trash_unit")
}
