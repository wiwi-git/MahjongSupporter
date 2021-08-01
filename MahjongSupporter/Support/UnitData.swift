//
//  UnitData.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/15.
// View: https://www.figma.com/file/fvIc4AZLbGt7Xw7cxZGS4B/%EB%A7%88%EC%9E%91%ED%8C%A8?node-id=5%3A1290

import UIKit
struct UnitButtonSize {
    //160 × 240
    //16:24
    //8:12
    //4:6 =  72: x
    //x = 108
    var width = 72
    var height = 108
}

struct UnitData {
    enum KeyType:String {
        case kanji = "ka"
        case bamboo = "ba"
        case dot = "do"
        case char = "ch"
    }
    static func getKeyType(key:String) -> UnitData.KeyType? {
        let lastIndex = key.index(key.startIndex, offsetBy: 2)
        let filtered = key[key.startIndex ..< lastIndex]
        return UnitData.KeyType(rawValue: String(filtered))
    }
    
    enum KanjiKey: String {
        case kanji1 = "kanji1"
        case kanji2 = "kanji2"
        case kanji3 = "kanji3"
        case kanji4 = "kanji4"
        case kanji5 = "kanji5"
        case kanji6 = "kanji6"
        case kanji7 = "kanji7"
        case kanji8 = "kanji8"
        case kanji9 = "kanji9"
    }
    
    enum BambooKey: String {
        case bamboo1 = "bamboo1"
        case bamboo2 = "bamboo2"
        case bamboo3 = "bamboo3"
        case bamboo4 = "bamboo4"
        case bamboo5 = "bamboo5"
        case bamboo6 = "bamboo6"
        case bamboo7 = "bamboo7"
        case bamboo8 = "bamboo8"
        case bamboo9 = "bamboo9"
    }
    
    enum DotKey: String {
        case dot1 = "dot1"
        case dot2 = "dot2"
        case dot3 = "dot3"
        case dot4 = "dot4"
        case dot5 = "dot5"
        case dot6 = "dot6"
        case dot7 = "dot7"
        case dot8 = "dot8"
        case dot9 = "dot9"
    }
    
    enum CharacterKey: String {
        case charEast1 = "charEast1"
        case charWest2 = "charWest2"
        case charSouth3 = "charSouth3"
        case charNorth4 = "charNorth4"
        case charHaku5 = "charHaku5"
        case charChuu6 = "charChuu6"
        case charHatsu7 = "charHatsu7"
    }
    
    static let SectionHeader:[KeyType:String] = [
        .bamboo:"삭수패",
        .char:"자패",
        .dot:"통수패",
        .kanji:"만수패"
    ]
    
    let kanji19: [KanjiKey:UIImage] = [
        .kanji1:UIImage(named: "man1")!,
        .kanji2:UIImage(named: "man2")!,
        .kanji3:UIImage(named: "man3")!,
        .kanji4:UIImage(named: "man4")!,
        .kanji5:UIImage(named: "man5")!,
        .kanji6:UIImage(named: "man6")!,
        .kanji7:UIImage(named: "man7")!,
        .kanji8:UIImage(named: "man8")!,
        .kanji9:UIImage(named: "man9")!,
    ]
    
    let bamboo19:[BambooKey:UIImage] = [
        .bamboo1:UIImage(named: "sac1")!,
        .bamboo2:UIImage(named: "sac2")!,
        .bamboo3:UIImage(named: "sac3")!,
        .bamboo4:UIImage(named: "sac4")!,
        .bamboo5:UIImage(named: "sac5")!,
        .bamboo6:UIImage(named: "sac6")!,
        .bamboo7:UIImage(named: "sac7")!,
        .bamboo8:UIImage(named: "sac8")!,
        .bamboo9:UIImage(named: "sac9")!
    ]
    
    let dot19:[DotKey:UIImage] = [
        .dot1:UIImage(named: "dot1")!,
        .dot2:UIImage(named: "dot2")!,
        .dot3:UIImage(named: "dot3")!,
        .dot4:UIImage(named: "dot4")!,
        .dot5:UIImage(named: "dot5")!,
        .dot6:UIImage(named: "dot6")!,
        .dot7:UIImage(named: "dot7")!,
        .dot8:UIImage(named: "dot8")!,
        .dot9:UIImage(named: "dot9")!
    ]
    
    let character:[CharacterKey:UIImage] = [
        .charEast1:UIImage(named: "jaEast")!,
        .charWest2:UIImage(named: "jaWest")!,
        .charSouth3:UIImage(named: "jaSouth")!,
        .charNorth4:UIImage(named: "jaNorth")!,
        .charHaku5:UIImage(named: "jaHaku")!,
        .charHatsu7:UIImage(named: "jaHatsu")!,
        .charChuu6:UIImage(named: "jaChuu")!,
    ]
}

let text = [
    //자패
    "東",//동
    "西",//서
    "南",//남
    "北",//북
    "萬",//일만 만
    "発",//쏠 발
]

struct Unit {
    let id:String
    let image:UIImage
    let key:String
}
