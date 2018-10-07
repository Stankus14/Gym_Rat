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
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class GameScreenView: UIViewController {
    
    var user = GymRat()
    var frenzyCountUpTimer = Timer()
    var frenzyCountDownTimer = Timer()
    var frenzyCounter: Int = 0
    var frenzyActive : Bool = false
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var weightImage: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var exercisesButton: UIButton!
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var frenzyBar: UIView!
    @IBOutlet weak var exercisesView: UIView!
    
    let screenSize = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frenzyCountUpTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarUpdate), userInfo: nil, repeats: true)
        frenzyCounter = 0
        frenzyBar.frame.size.width = 0
        updateUI()
        levelBar()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func LiftDB(_ sender: UIButton) {
        
        let weight = user.DBPress.getCurrentWeight()
        
        if (frenzyActive){
            user.totalWeightsLifted = user.totalWeightsLifted + (weight * 3)
            user.rank.addTap()
            user.rank.ableForUpgrade()
            addTapLabel()
        }
        else {
            user.totalWeightsLifted = user.totalWeightsLifted + user.DBPress.getCurrentWeight()
            user.rank.addTap()
            user.rank.ableForUpgrade()
            addTapLabel()
            //shapeLayer.strokeEnd = CGFloat(user.rank.tapCount / 8000)
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
        
        if (frenzyCounter == 400) {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 400) * CGFloat(frenzyCounter)
            frenzyBar.backgroundColor = UIColor.cyan
            frenzyCountUpTimer.invalidate()
            frenzyActive = true
            frenzyCountDownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarDownUpdate), userInfo: nil, repeats: true)
        }
        else {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 400) * CGFloat(frenzyCounter)
        }
    }
    
    @objc func frenzyBarDownUpdate() {
        frenzyCounter -= 10
        
        if (frenzyCounter == 0) {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 400) * CGFloat(frenzyCounter)
            frenzyBar.backgroundColor = UIColor.white
            frenzyCountDownTimer.invalidate()
            frenzyActive = false
            frenzyCountUpTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScreenView.frenzyBarUpdate), userInfo: nil, repeats: true)
        }
        else {
            frenzyBar.frame.size.width = ((view.frame.size.width - 62) / 400) * CGFloat(frenzyCounter)
        }
    }
    
    func levelBar(){
        
        
            // Do any additional setup after loading the view, typically from a nib.
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var center = view.center
        center.x = screenWidth * (11 / 100)
        center.y = screenHeight * (9 / 100)
        
            let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
            trackLayer.path = circularPath.cgPath
            trackLayer.strokeColor = UIColor.lightGray.cgColor
            trackLayer.lineWidth = 10
            trackLayer.fillColor = UIColor.clear.cgColor
            trackLayer.lineCap = kCALineCapRound
            view.layer.addSublayer(trackLayer)
            
            shapeLayer.path = circularPath.cgPath
            shapeLayer.strokeColor = UIColor(hexString: "#8C7853").cgColor
            shapeLayer.lineWidth = 10
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineCap = kCALineCapRound
            shapeLayer.strokeEnd = 0
            view.layer.addSublayer(shapeLayer)
        
            
            //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        }
        
        
        @objc private func handleTap()
        {
            
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            
            basicAnimation.toValue = 1
            
            basicAnimation.duration = 2
            
            basicAnimation.fillMode = kCAFillModeForwards
            basicAnimation.isRemovedOnCompletion = false
            
            shapeLayer.add(basicAnimation, forKey: "hellyeah")
        }
    func addTapLabel() {
        var center = view.center
        let weight = user.DBPress.getCurrentWeight()
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let tapLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        if frenzyActive {
            tapLabel.text = "+\(weight * 3)"
            tapLabel.textColor = UIColor.cyan
        }
        else{
            tapLabel.text = "+\(weight)"
            tapLabel.textColor = UIColor.white
        }
        tapLabel.font = UIFont.boldSystemFont(ofSize: 25)
        var rand = CGFloat.random(in: 25 ... 75)
        let posX = screenWidth * (rand / 100)
        rand = CGFloat.random(in: 40 ... 75)
        let posY = screenHeight * (rand / 100)
        center.x = posX
        center.y = posY
        
        tapLabel.center = center
        self.view.addSubview(tapLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear], animations: {
            tapLabel.center.y = tapLabel.center.y - 40
            tapLabel.alpha = 0
        }
            ,completion: nil)
    }
    

//////////////////////////////////////////
    
    
    
    
    

  
}



