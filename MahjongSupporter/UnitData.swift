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
    enum KeyType {
        case kanji
        case bamboo
        case dotKey
        case char
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
        case east = "chareast"
        case west = "cahrwest"
        case south = "charsouth"
        case north = "charnorth"
        case haku = "charhaku"
        case hatsu = "charhatsu"
        case chuu = "charchuu"
    }
    
    var kanji19: [KanjiKey:UIImage] = [
        .kanji1:UIImage(named: "만1")!,
        .kanji2:UIImage(named: "만2")!,
        .kanji3:UIImage(named: "만3")!,
        .kanji4:UIImage(named: "만4")!,
        .kanji5:UIImage(named: "만5")!,
        .kanji6:UIImage(named: "만6")!,
        .kanji7:UIImage(named: "만7")!,
        .kanji8:UIImage(named: "만8")!,
        .kanji9:UIImage(named: "만9")!
    ]
    
    var bamboo19:[BambooKey:UIImage] = [
        .bamboo1:UIImage(named: "삭1")!,
        .bamboo2:UIImage(named: "삭2")!,
        .bamboo3:UIImage(named: "삭3")!,
        .bamboo4:UIImage(named: "삭4")!,
        .bamboo5:UIImage(named: "삭5")!,
        .bamboo6:UIImage(named: "삭6")!,
        .bamboo7:UIImage(named: "삭7")!,
        .bamboo8:UIImage(named: "삭8")!,
        .bamboo9:UIImage(named: "삭9")!
    ]
    
    var dot19:[DotKey:UIImage] = [
        .dot1:UIImage(named: "통1")!,
        .dot2:UIImage(named: "통2")!,
        .dot3:UIImage(named: "통3")!,
        .dot4:UIImage(named: "통4")!,
        .dot5:UIImage(named: "통5")!,
        .dot6:UIImage(named: "통6")!,
        .dot7:UIImage(named: "통7")!,
        .dot8:UIImage(named: "통8")!,
        .dot9:UIImage(named: "통9")!
    ]
    
    var character:[CharacterKey:UIImage] = [
        .east:UIImage(named: "자-동")!,
        .west:UIImage(named: "자-서")!,
        .south:UIImage(named: "자-남")!,
        .north:UIImage(named: "자-북")!,
        .haku:UIImage(named: "자-백")!,
        .hatsu:UIImage(named: "자-발")!,
        .chuu:UIImage(named: "자-중")!,
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
    let text:String
}
