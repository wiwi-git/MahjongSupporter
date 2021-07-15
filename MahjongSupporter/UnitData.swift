//
//  UnitData.swift
//  MahjongSupporter
//
//  Created by 위대연 on 2021/07/15.
//

import UIKit

struct UnitText {
    let extensionType = "png"
    var kanji19:[String] = [
        "kinji1",
        "kinji2",
        "kinji3",
        "kinji4",
        "kinji5",
        "kinji6",
        "kinji7",
        "kinji8",
        "kinji9"
    ]
    var bamboo19:[String] = [
        "bamboo1",
        "bamboo2",
        "bamboo3",
        "bamboo4",
        "bamboo5",
        "bamboo6",
        "bamboo7",
        "bamboo8",
        "bamboo9",
    ]
    var dot19:[String] = [
        "dot1",
        "dot2",
        "dot3",
        "dot4",
        "dot5",
        "dot6",
        "dot7",
        "dot8",
        "dot9"
    ]
    var character:[String] = [
        "east",
        "west",
        "south",
        "north",
        "man",//일만만
        "hachu"//쏠발
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
    let id:Int
    var text:String
    var color:UIColor
}
