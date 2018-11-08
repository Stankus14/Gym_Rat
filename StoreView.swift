//
//  StoreView.swift
//  Gym Rat
//
//  Created by Will Stankus on 6/27/18.
//  Copyright © 2018 Will Stankus. All rights reserved.
//

import UIKit

class  StoreView: UIViewController  {
    
    var userStore : GymRat!
    
    @IBOutlet weak var DBNameLabel: UILabel!
    @IBOutlet weak var DBLevelLabel: UILabel!
    @IBOutlet weak var DBWeightLabel: UILabel!
    @IBOutlet weak var DBCostLabel: UILabel!
    
    
    @IBOutlet weak var BenchNameLabel: UILabel!
    @IBOutlet weak var BenchLevelLabel: UILabel!
    @IBOutlet weak var BenchWeightLabel: UILabel!
    @IBOutlet weak var BenchCostLabel: UILabel!
    
    @IBOutlet weak var DeadliftNameLabel: UILabel!
    @IBOutlet weak var DeadliftLevelLabel: UILabel!
    @IBOutlet weak var DeadliftWeightLabel: UILabel!
    @IBOutlet weak var DeadliftCostLabel: UILabel!
    
    @IBOutlet weak var SquatNameLabel: UILabel!
    @IBOutlet weak var SquatLevelLabel: UILabel!
    @IBOutlet weak var SquatWeightLabel: UILabel!
    @IBOutlet weak var SquatCostLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DBUpgrade(_ sender: Any) {
       
        print("Level: \(userStore.DBPress.getLevel()) , Count: \(userStore.DBPress.costOfWeights.count)")
        
        if userStore.DBPress.getLevel() + 1 < userStore.DBPress.costOfWeights.count {
            
            if userStore.totalWeightsLifted > userStore.DBPress.costOfWeights[userStore.DBPress.getLevel() + 1]{

                userStore.totalWeightsLifted = userStore.totalWeightsLifted - userStore.DBPress.costOfWeights[userStore.DBPress.getLevel() + 1]
                userStore.DBPress.setLevel(newLevel: userStore.DBPress.getLevel() + 1)
                userStore.DBPress.setWeight(newWeight: userStore.DBPress.currentListofWeights[userStore.DBPress.getLevel()])
                updateUI()
            
            }
            else {
                // say you dont have enough points
            }
        }
        else {
            print("MAXED OUT")
        }
    }
    
    @IBAction func BenchUpgrade(_ sender: Any) {
        
        if userStore.BenchPress.getLevel() + 1 < userStore.BenchPress.costOfWeights.count {
            
            if userStore.totalWeightsLifted > userStore.BenchPress.costOfWeights[userStore.BenchPress.getLevel() + 1]{
                
                userStore.totalWeightsLifted = userStore.totalWeightsLifted - userStore.BenchPress.costOfWeights[userStore.BenchPress.getLevel() + 1]
                userStore.BenchPress.setLevel(newLevel: userStore.BenchPress.getLevel() + 1)
                updateUI()
            }
            else {
                // say you dont have enough points
            }
        }
        else {
            print("MAXED OUT")
        }
    }
    
    @IBAction func DeadliftUpgrade(_ sender: Any) {
        
        if userStore.Deadlift.getLevel() + 1 < userStore.Deadlift.costOfWeights.count {
            
            if userStore.totalWeightsLifted > userStore.Deadlift.costOfWeights[userStore.Deadlift.getLevel() + 1]{
                
                userStore.totalWeightsLifted = userStore.totalWeightsLifted - userStore.Deadlift.costOfWeights[userStore.Deadlift.getLevel() + 1]
                userStore.Deadlift.setLevel(newLevel: userStore.Deadlift.getLevel() + 1)
                updateUI()
            }
            else {
                // say you dont have enough points
            }
        }
        else {
            print("MAXED OUT")
        }
    }
    
    
    
    @IBAction func SquatUpgrade(_ sender: Any) {
        
        if userStore.Squat.getLevel() + 1 < userStore.Squat.costOfWeights.count {
            
            if userStore.totalWeightsLifted > userStore.Squat.costOfWeights[userStore.Squat.getLevel() + 1]{
                
                userStore.totalWeightsLifted = userStore.totalWeightsLifted - userStore.Squat.costOfWeights[userStore.Squat.getLevel() + 1]
                userStore.Squat.setLevel(newLevel: userStore.Squat.getLevel() + 1)
                updateUI()
            }
            else {
                // say you dont have enough points
            }
        }
        else {
            print("MAXED OUT")
        }
    }
    func updateUI () {
        
        //////////////DUMBBELL PRESS/////////////////
        
        DBNameLabel.text = userStore.DBPress.getExerciseName()
        DBLevelLabel.text = "Level: \(userStore.DBPress.getLevel() + 1) / \(userStore.DBPress.costOfWeights.count)"
        DBWeightLabel.text = "\(userStore.DBPress.listOfWeights[userStore.DBPress.getLevel() + 1])"
            if userStore.DBPress.getLevel() < userStore.DBPress.costOfWeights.capacity - 1 {
                DBCostLabel.text = "\(userStore.DBPress.costOfWeights[userStore.DBPress.getLevel() + 1].withCommas())"
            }
            else {
                DBCostLabel.text = "MAXED"
            }

       //////////////BENCH PRESS////////////////////
        
        BenchNameLabel.text = userStore.BenchPress.getExerciseName()
        BenchLevelLabel.text = "Level: \(userStore.BenchPress.getLevel() + 1) / \(userStore.BenchPress.costOfWeights.count)"
        BenchWeightLabel.text = "\(userStore.BenchPress.listOfWeights[userStore.BenchPress.getLevel() + 1])"
        if userStore.BenchPress.getLevel() < userStore.BenchPress.costOfWeights.capacity - 1 {
            BenchCostLabel.text = "\(userStore.BenchPress.costOfWeights[userStore.BenchPress.getLevel() + 1].withCommas())"
        }
        else {
            BenchCostLabel.text = "MAXED"
        }
        
        /////////////SQUAT//////////////
        
        SquatNameLabel.text = userStore.Squat.getExerciseName()
        SquatLevelLabel.text = "Level: \(userStore.Squat.getLevel() + 1) / \(userStore.Squat.costOfWeights.count)"
        SquatWeightLabel.text = "\(userStore.Squat.listOfWeights[userStore.Squat.getLevel() + 1])"
        if userStore.Squat.getLevel() < userStore.Squat.costOfWeights.capacity - 1 {
            SquatCostLabel.text = "\(userStore.Squat.costOfWeights[userStore.Squat.getLevel() + 1].withCommas())"
        }
        else {
            SquatCostLabel.text = "MAXED"
        }
        
        ///////////DEADLIFT/////////////
        
        DeadliftNameLabel.text = userStore.Deadlift.getExerciseName()
        DeadliftLevelLabel.text = "Level: \(userStore.Deadlift.getLevel() + 1) / \(userStore.Deadlift.costOfWeights.count)"
        DeadliftWeightLabel.text = "\(userStore.Deadlift.listOfWeights[userStore.Deadlift.getLevel() + 1])"
        if userStore.Deadlift.getLevel() < userStore.Deadlift.costOfWeights.capacity - 1 {
            DeadliftCostLabel.text = "\(userStore.Deadlift.costOfWeights[userStore.Deadlift.getLevel() + 1].withCommas())"
        }
        else {
            DeadliftCostLabel.text = "MAXED"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DestinationController : GameScreenView = segue.destination as! GameScreenView
        DestinationController.user = userStore
    
    }
    
    @IBAction func backToGame(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    
}
