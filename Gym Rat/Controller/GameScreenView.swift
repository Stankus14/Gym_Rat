//
//  ViewController.swift
//  Gym Rat
//
//  Created by Will Stankus on 5/20/18.
//  Copyright © 2018 Will Stankus. All rights reserved.
//

import UIKit

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

class GameScreenView: UIViewController {
    
    var user = GymRat()
    var frenzyCountUpTimer = Timer()
    var frenzyCountDownTimer = Timer()
    var frenzyCounter: Int = 0
    var frenzyActive : Bool = false
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var weightImage: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var exercisesButton: UIButton!
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var frenzyBar: UIView!
    @IBOutlet weak var exercisesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frenzyCountUpTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarUpdate), userInfo: nil, repeats: true)
        frenzyCounter = 0
        frenzyBar.frame.size.width = 0
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func LiftDB(_ sender: UIButton) {
        
        if (frenzyActive){
            user.totalWeightsLifted = user.totalWeightsLifted + (user.DBPress.getCurrentWeight() * 3)
            user.rank.addTap()
            user.rank.ableForUpgrade()
        }
        else {
            user.totalWeightsLifted = user.totalWeightsLifted + user.DBPress.getCurrentWeight()
            user.rank.addTap()
            user.rank.ableForUpgrade()
        }
        updateUI()
    }
    
    @IBAction func LiftBench(_ sender: Any) {
        if (frenzyActive){
            user.totalWeightsLifted = user.totalWeightsLifted + (user.BenchPress.currentWeight * 3)
            user.rank.addTap()
            user.rank.ableForUpgrade()
        }
        else {
            user.totalWeightsLifted = user.totalWeightsLifted + user.BenchPress.currentWeight
            user.rank.addTap()
            user.rank.ableForUpgrade()
        }
        updateUI()
    }
    
    func updateUI() {
      
        totalWeightLabel.text = "\(user.totalWeightsLifted.withCommas())"
        weightImage.setImage(UIImage(named: user.DBPress.buttonArray[user.DBPress.getLevel()]), for: .normal)
        //change button image
        //weightImage.setImage(UIImage(named: "40 pound dumbbell"), for: .normal)
        
        //check button image
        //if weightImage.currentImage == UIImage(named: "gymRat")
        
        
    }
    
    @IBAction func storeButtonPressed(_ sender: UIButton) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let barViewControllers = segue.destination as! UITabBarController
        let storeVC = barViewControllers.viewControllers?[0] as! StoreView
        storeVC.userStore = user
        
        // access the second tab bar
        //        let secondDes = barViewControllers.viewControllers?[1] as! SecondViewController
        //        secondDes.test = "Hello TabBar 2"
    }
    
    ////////////////////////////////////////
    //         CHANGE EXERCISES
    /////////////////////////////////////////
    @IBAction func exercisesButtonPressed(_ sender: UIButton) {
        exercisesView.isHidden = false
    }
    @IBAction func switchToDBPress(_ sender: Any) {
        weightImage.setImage(UIImage(named: user.DBPress.imageName), for: .normal)
        exercisesView.isHidden = true
    }
    @IBAction func switchToBenchPress(_ sender: Any) {
        weightImage.setImage(UIImage(named: user.BenchPress.imageName), for: .normal)
        exercisesView.isHidden = true
    }
    @IBAction func switchToDeadlift(_ sender: Any) {
        weightImage.setImage(UIImage(named: user.Deadlift.imageName), for: .normal)
        exercisesView.isHidden = true
    }
    @IBAction func switchToSquat(_ sender: Any) {
        weightImage.setImage(UIImage(named: user.Squat.imageName), for: .normal)
        exercisesView.isHidden = true
    }
    ////////////////////////////////////////
    //           FRENZY TIMER
    /////////////////////////////////////////
    @objc func frenzyBarUpdate () {
        frenzyCounter += 1
        
        if (frenzyCounter == 200) {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 200) * CGFloat(frenzyCounter)
            frenzyBar.backgroundColor = UIColor.cyan
            frenzyCountUpTimer.invalidate()
            frenzyActive = true
            frenzyCountDownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarDownUpdate), userInfo: nil, repeats: true)
        }
        else {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 200) * CGFloat(frenzyCounter)
        }
    }
    
    @objc func frenzyBarDownUpdate() {
        frenzyCounter -= 20
        
        if (frenzyCounter == 0) {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 200) * CGFloat(frenzyCounter)
            frenzyBar.backgroundColor = UIColor.white
            frenzyCountDownTimer.invalidate()
            frenzyActive = false
            frenzyCountUpTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarUpdate), userInfo: nil, repeats: true)
        }
        else {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 200) * CGFloat(frenzyCounter)
        }
    }
    
    //////////////////////////////////////////
    
    
    
    
    

  
}


