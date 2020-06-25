//
//  ViewController.swift
//  Bull'sEye
//
//  Created by Sherin Roy on 23/06/2020.
//  Copyright © 2020 Sherin Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var currentSliderValue = 0
    var targetValue = 0
    var difference = 0
    var points = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftSide = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftSide.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightSide = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightSide.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    @IBAction func showAlert() {
        calculatePoints()
        
        let alert = UIAlertController(title: formTitle(), message: "You scored \(points) points!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentSliderValue = Int(slider.value.rounded())
    }
    
    func formTitle() -> String {
        if difference == 0 {
            return "Perfect!"
        } else if difference < 5 {
            return "You almost had it!"
        } else if difference < 10 {
            return "Pretty good!"
        } else {
            return "Not even close..."
        }
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        roundLabel.text = String(round)
        randomLabel.text = String(targetValue)
        scoreLabel.text = String(score)
    }
    
    func calculatePoints() {
        difference = abs(targetValue - currentSliderValue)
        
        if difference == 0 {
            points = 100 - difference + 100
        } else if difference == 1 {
            points = 100 - difference + 50
        } else {
            points = 100 - difference
        }
        score += points
    }
    
    @IBAction func startOver() {
        score = 0
        round = 0
        startNewRound()
    }
}

