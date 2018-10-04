//
//  RankSystem.swift
//  Gym Rat
//
//  Created by Will Stankus on 8/7/18.
//  Copyright © 2018 Will Stankus. All rights reserved.
//

import Foundation

class RankSystem {
    
    var tier : Int
    var rank : Int
    var tapCount: Int
    var rankNames : [String] = ["Novice" , "Amatuer" , "Pro" , "Elite"]
    
    init(tier : Int, rank: Int) {
        self.tier = tier
        self.rank = rank
        tapCount = 0
    }
    
    func upgrade () {
        if tier == 5 {
            rank += 1
            tier = 1
        }
        else {
            tier += 1
        }
    }
    
    func addTap () {
        tapCount += 1
    }
    
    func ableForUpgrade () {
        if tapCount >= 8000 {
            upgrade()
            tapCount = 0
        }
        else {
            
        }
    }
    

    
}
