//
//  Exercise.swift
//  Gym Rat
//
//  Created by Will Stankus on 6/26/18.
//  Copyright © 2018 Will Stankus. All rights reserved.
//

import Foundation


class Exercise {
    
    var currentWeight: Int
    var exerciseName : String
    var imageName: String
    var level : Int
    var costOfWeights: [Int]
    var unlockPrice : Int
    var listOfWeights: [String]
    var currentImage: String
    var buttonArray : [String]
    var currentListofWeights: [Int]
    
    init(startingWeight : Int, Name: String, costWeights : [Int], unlock : Int, listWeights: [String], Image: String, buttons: [String], currentWeights : [Int]) {
        
        currentWeight = startingWeight
        exerciseName = Name
        level = 0
        imageName = "15 pound dumbbell"
        costOfWeights = costWeights
        unlockPrice = unlock
        listOfWeights = listWeights
        currentImage = Image
        buttonArray = buttons
        currentListofWeights = currentWeights
        
    }
    
    func getCurrentWeight () -> Int {
        return currentWeight
    }
    
    func setWeight(newWeight : Int) {
        currentWeight = newWeight
    }
    
    func setLevel (newLevel : Int) {
        level = newLevel
    }
    
    func getLevel () -> Int {
        return level
    }
    
    func getExerciseName () -> String {
        return exerciseName
    }
    
    func getImageName() -> String {
        return currentImage
    }
    
    func setImageName(newImageName : String) {
        imageName = newImageName
    }
    
    
    
    
    
   
}
