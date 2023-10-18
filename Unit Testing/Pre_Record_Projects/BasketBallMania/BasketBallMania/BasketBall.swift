//
//  BasketBall.swift
//  BasicApp_UnitTest
//
//  Created by Faiaz Rahman on 9/7/23.
//

import UIKit

class BasketBall: UIViewController {

    @IBOutlet weak var wicketVertical: NSLayoutConstraint!
    
    @IBOutlet weak var ballVertical: NSLayoutConstraint!
    
    @IBOutlet weak var ballHorizontal: NSLayoutConstraint!
    @IBOutlet weak var counterView: UILabel!
    
    @IBOutlet weak var ballImage: UIImageView!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var toastLabel: UILabel!
    @IBOutlet weak var wicketImage: UIImageView!
    
    var arrowPosition = 0
    var ballPlace = 0
    var count = 0
    var highscore = 0
    var defaults = UserDefaults.standard
    var currentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        highscore = defaults.integer(forKey: "highscore")
        highScoreLabel.text = "High Score: \(highscore)"
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        defaults.set(highscore,forKey: "highscore")
    }
    
    @IBAction func throwBtn(_ sender: Any) {
        tapped()
    }
    func tapped(){
        let options: UIView.AnimationOptions = [.curveEaseInOut]

        UIView.animate(withDuration: 2,delay: 0,options: options, animations: { [weak self] in
            
            self?.ballPlace = -350
            self?.ballHorizontal.constant = CGFloat(self!.ballPlace)

            self?.view.layoutIfNeeded()

        }, completion: {[weak self] _ in
            
            if (self!.ballImage.frame.intersects(self!.wicketImage.frame)){
               
                self?.currentScore += 1
                self?.count += 1
                self?.counterView.text = String(self!.count)
                
                self?.wicketVertical.constant = .random(in: -132...132)
                
                if self!.currentScore > self!.highscore{
                    self?.highscore = self!.currentScore
                    self?.highScoreLabel.text = "High Score: \((self?.highscore)!)"
                }

//                self?.wicketImage.image = UIImage(named: "wicketB")
                self?.toastLabel.text = "Shoot !!"
                self?.toastLabel.alpha = 0
                UIView.animate(withDuration: 0.5) {
                    self?.toastLabel.alpha = 1
                }

                // Wait for 3 seconds and then fade out the label with an animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.toastLabel.alpha = 0
                    }, completion: { _ in
                        // Reset the label's text and alpha when the animation completes
                        self?.toastLabel.text = ""
                        self?.toastLabel.alpha = 1
                    })
                }
                
            }
            UIView.transition(with: (self?.wicketImage)!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self?.wicketImage.image = UIImage(named: "basketballpost")
                              },
                              completion: nil)
          
            self?.ballHorizontal.constant = 250
        })
    }
    
    
    @IBAction func rightBtn(_ sender: Any) {
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        
        UIView.animate(withDuration: 0.4,delay: 0,options: options, animations: { [weak self] in
            self?.arrowPosition += 50
            
            let position =  self?.arrowPosition
            self?.ballVertical.constant = CGFloat(position!)
            self?.ballImage.transform = (self?.ballImage.transform.rotated(by: CGFloat.pi/4))!

                    self?.view.layoutIfNeeded()
                  }, completion: nil)
        }
    
    @IBAction func leftBtn(_ sender: Any) {
        
        let options: UIView.AnimationOptions = [.curveEaseInOut]
//                                                .repeat,
//                                                .autoreverse]

UIView.animate(withDuration: 0.4,delay: 0,options: options, animations: { [weak self] in
    self?.arrowPosition -= 50
    
    let position =  self?.arrowPosition
    self?.ballVertical.constant = CGFloat(position!)
    self?.ballImage.transform = (self?.ballImage.transform.rotated(by: -45))!
    self?.view.layoutIfNeeded()
          }, completion: nil)
        
    }
    
    
}
