//
//  GymRat.swift
//  Gym Rat
//
//  Created by Will Stankus on 6/26/18.
//  Copyright © 2018 Will Stankus. All rights reserved.
//

import Foundation
//hey
//400 taps per min
//4000 taps per level     around 10 min per level

class GymRat {
    
    var totalWeightsLifted : Int
    
    let DBPress : Exercise
    let BenchPress : Exercise
    let Deadlift : Exercise
    let Squat : Exercise
    let rank : RankSystem
    
    

    init() {
        totalWeightsLifted = 0
        self.DBPress = Exercise(startingWeight: 20, Name: "Dumbbell Press", costWeights: [0, 80000, 120000, 160000, 200000, 240000, 280000, 320000, 400000, 480000, 560000, 640000, 720000, 800000], unlock: 0, listWeights: ["10's", "15's", "20's", "25's", "30's", "35's", "40's", "45's", "50's", "60's", "70's", "80's", "90's", "100's", "MAX"], Image: "15 pound dumbbell", buttons: ["10 pound dumbbells", "15 pound dumbbells", "20 pound dumbbells", "25 pound dumbbells", "30 pound dumbbells", "35 pound dumbbells", "40 pound dumbbells", "45 pound dumbbells", "50 pound dumbbells", "60 pound dumbbells", "70 pound dumbbells", "80 pound dumbbells", "90 pound dumbbells", "100 pound dumbbells"], currentWeights: [20,30,40,50,60,70,80,90,100,120,140,160,180,200])
        self.BenchPress = Exercise(startingWeight: 225, Name: "Bench Press", costWeights: [900000, 980000, 1060000, 1140000, 1220000, 1300000, 1380000, 1460000, 1540000], unlock: 900000, listWeights: ["225", "245", "265", "285", "305", "325", "345", "365", "385", "MAX"], Image: "20 pound dumbbell", buttons: [], currentWeights:[0,1])
        self.Deadlift = Exercise(startingWeight: 405, Name: "Deadlift", costWeights: [1620000, 1700000, 1780000, 1860000, 1940000, 2020000, 2100000, 2180000, 2260000], unlock: 1620000, listWeights: ["405", "425", "445", "465", "485", "505", "525", "545", "565", "MAX"], Image: "25 pound dumbbell", buttons: [], currentWeights : [0,1])
        self.Squat = Exercise(startingWeight: 585, Name: "Squat", costWeights: [2340000, 2420000, 2500000, 2580000, 2660000, 2740000, 2820000, 2900000], unlock: 2340000, listWeights: ["585", "605", "625", "645", "665", "685", "705", "725", "MAX"], Image: "30 pound dumbbell", buttons: [], currentWeights : [0,1])
        self.rank = RankSystem(tier: 1, rank: 0)
        
        
        
    }
}







