//
//  PlayerStats.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/5/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import Foundation
import UIKit


class PlayerStats {
    
    var name: String?
    var playerImage: UIImage?
    var playerHeight: String?
    var playerWeight: String?
    var playerSalary: String?
    var playerPosition: String?
    var playerTeam: String?
    var playerImageLink: URL?
    var QBArray = Array<Any>()
    var RBArray = Array<Any>()
    var data: Data?
    
    init(){
        name = ""
        playerImageLink = URL(string: "")
        playerHeight = ""
        playerWeight = ""
        playerSalary = ""
        playerTeam = ""
        playerPosition = ""
    }
    
    init (name: String, playerImageLink: URL, playerHeight:String, playerWeight: String, playerTeam:String, playerSalary:String, playerPosition: String){
        self.name = name
        self.playerImageLink = playerImageLink
        self.playerHeight = playerHeight
        self.playerWeight = playerWeight
        self.playerSalary = playerSalary
        self.playerTeam = playerTeam
        self.playerPosition = playerPosition
    }
    
}

