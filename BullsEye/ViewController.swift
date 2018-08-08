//
//  ViewController.swift
//  BullsEye
//
//  Created by Ardita Morina on 06/08/2018.
//  Copyright © 2018 Ardita Morina. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var difference: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       startNewGame()
       updateLabels()
      
         let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
 
        
    }

    //Ne momentin qe klikojme tek butoni start Over, thirret ky funksion
    @IBAction func startOver(_ sender: Any) {
      startNewGame()
        updateLabels()
    
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }

    //Funksion qe mundeson round e ri
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50 ;
        slider.value = Float(currentValue)
        
    }
    
    //funksion qe ben update labels
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
    //funksion qe ben update differencen
    func updateDifference(){
        if(targetValue<currentValue){
            difference = currentValue - targetValue
            scoreLabel.text = String(difference)
        }
        else if(targetValue>currentValue){
            difference = targetValue - currentValue
            scoreLabel.text = String(difference)
        }
        else if(targetValue==currentValue){
            difference = 0
            scoreLabel.text = String(difference)
        }
    
    }
  
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Ne momentin qe klikohet butoni Hit me, i shfaqet shfrytezuesit nje Alert
    @IBAction func showAlert(){
        updateDifference()
        var points = 100 - difference
        score += points
        let message = "You scored \(points) points"
        //let message = "The value of he slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference)"
        
        let title: String
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        }else if difference < 5 {
            title = "You almos had it!"
            if difference == 1 {
                points += 50
            }
        }else if difference < 10 {
            title = "Pretty good!"}
        else {
            title = " Not even close..."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler:{ action in
                                            self.startNewRound()
                                            self.updateLabels()
            
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    
    //Funksion per start new game
    func startNewGame() {
            score = 0
            round = 0
            startNewRound()
        
    }
    
    //funksion qe thirret ne momentin kur preket slider
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print(currentValue)
    }
    
    
    
    
}

