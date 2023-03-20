//
//  ViewController.swift
//  catchGame
//
//  Created by Alper Şahin on 2.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var alperArray = [UIImageView] ()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var resButton: UIButton!
    //Views
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var alper1: UIImageView!
    
    @IBOutlet weak var alper2: UIImageView!
    
    @IBOutlet weak var alper3: UIImageView!
    
    @IBOutlet weak var alper4: UIImageView!
    
    @IBOutlet weak var alper5: UIImageView!
    
    @IBOutlet weak var alper6: UIImageView!
    
    @IBOutlet weak var alper7: UIImageView!
    
    @IBOutlet weak var alper8: UIImageView!
    
    @IBOutlet weak var alper9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score : \(score)"
        
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "Highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
     
        
        //Images
        alper1.isUserInteractionEnabled = true
        alper2.isUserInteractionEnabled = true
        alper3.isUserInteractionEnabled = true
        alper4.isUserInteractionEnabled = true
        alper5.isUserInteractionEnabled = true
        alper6.isUserInteractionEnabled = true
        alper7.isUserInteractionEnabled = true
        alper8.isUserInteractionEnabled = true
        alper9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        alper1.addGestureRecognizer(recognizer1)
        alper2.addGestureRecognizer(recognizer2)
        alper3.addGestureRecognizer(recognizer3)
        alper4.addGestureRecognizer(recognizer4)
        alper5.addGestureRecognizer(recognizer5)
        alper6.addGestureRecognizer(recognizer6)
        alper7.addGestureRecognizer(recognizer7)
        alper8.addGestureRecognizer(recognizer8)
        alper9.addGestureRecognizer(recognizer9)
        
        alperArray = [alper1,alper2,alper3,alper4,alper5,alper6,alper7,alper8,alper9
        ]
        
        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAlper), userInfo: nil, repeats: true)
        hideAlper()
    }
    

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        resButton.isHidden = true
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            resButton.isHidden = false
           
            resButton.addTarget(resButton, action: #selector(resButtttonTapped), for: .touchDown)
            
            for alper in alperArray {
                alper.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "Highscore")
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Timer's Up !!!", message: "Do you want repeat ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
            
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideAlper), userInfo: nil, repeats: true)
                
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
 
    
    @objc func hideAlper() {
        for alper in alperArray {
            alper.isHidden = true
        }
      let random = Int(arc4random_uniform(UInt32(alperArray.count - 1)))
        alperArray[random].isHidden = false
    }
    
    @objc func resButtttonTapped() {
        self.score = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.counter = 10
        self.timeLabel.text = String(self.counter)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideAlper), userInfo: nil, repeats: true)
    }
    
 
        
        }

    
    
    


