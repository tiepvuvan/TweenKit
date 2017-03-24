//
//  ViewController.swift
//  Example
//
//  Created by Steve Barnegren on 17/03/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import UIKit
import TweenKit

class TestViewController: UIViewController {
    
    let testView: UIView = {
        let view = UIView(frame: .zero)
        view.frame.size = CGSize(width: 30, height: 30)
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    let slider: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isUserInteractionEnabled = true
        slider.isContinuous = true
        return slider
    }()
    
    var lastTimeStamp: CFTimeInterval?
    var elapsedTime: CFTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // Add Subviews
        view.addSubview(testView)
        view.addSubview(slider)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        perform(#selector(startTheAnimation), with: nil, afterDelay: 3)
    }
    
    
     // COMPLEX
    /*
    func startTheAnimation() {
        
        print("Start the animation!")
        
        // move to the right
        let move = InterpolationAction(from: CGPoint(x: 0, y: 0),
                                         to: CGPoint(x: 300, y: 50),
                                         duration: 3) {
                                            self.testView.frame.origin = $0
        }
        move.easing = .elasticOut
        
        let scale = InterpolationAction(from: self.testView.frame.size,
                                        to: CGSize(width: 100, height: 100),
                                        duration: 3) {
                                            self.testView.frame.size = $0
        }
        
        let moveThenScale = Sequence(actions: move, scale)
        
        let changeColor = InterpolationAction(from: UIColor.blue,
                                              to: UIColor.red,
                                              duration: 10) {
                                                self.testView.backgroundColor = $0
        }
        
        let withChangeColor = Group(actions: moveThenScale, changeColor)
        
        
        let moveAgain = InterpolationAction(from: CGPoint(x: 300, y: 50),
                                            to: CGPoint(x: 100, y: 500),
                                            duration: 4) {
                                                self.testView.frame.origin = $0
        }
        moveAgain.easing = .exponentialInOut
        moveAgain.onBecomeActive = { print("Move again become active") }
        moveAgain.onBecomeInactive = { print("Move again become inactive") }
        
        
        let theWholeThing = Sequence(actions: withChangeColor, moveAgain)
        
        // Create the Animation
        let animation = Animation(action: theWholeThing.yoyo().reversed().repeated(2) )
        animation.run()
        
    }
 */
    
    
     // SEQUENCE
    /*
    func startTheAnimation() {
        
        print("Start the animation!")
        
        let speed = 100.0
        
        let moveRight = InterpolationAction(from: CGPoint(x: 10, y: 10),
                                       to: CGPoint(x: 250, y: 10),
                                       speed: speed) {
                                        self.testView.frame.origin = $0
        }
        
        let moveDown = InterpolationAction(from: CGPoint(x: 250, y: 10),
                                           to: CGPoint(x: 250, y: 40),
                                           speed: speed) {
                                            self.testView.frame.origin = $0
        }
        
        let moveLeft = InterpolationAction(from: CGPoint(x: 250, y: 40),
                                           to: CGPoint(x: 10, y: 40),
                                           speed: speed) {
                                            self.testView.frame.origin = $0
        }

        let sequence = Sequence(actions: moveRight, moveDown, moveLeft).yoyo().repeated(3)
        let animation = Animation(action: sequence)
        animation.run()
    }
 */
 
    
    // ARC
    func startTheAnimation() {
 
        let screenCenter = CGPoint(x: UIScreen.main.bounds.size.width/2,
                                   y: UIScreen.main.bounds.size.height/2)
        
        let action = ArcAction(center: screenCenter, radius: 100, startDegrees: 0, endDegrees: 360, duration: 5) {
            self.testView.center = $0
        }
        action.easing = .elasticInOut
        
        let animation = Animation(action: action.yoyo())
        animation.run()
    }

    
    // GROUP
    /*
    func startTheAnimation() {
        
        print("Start the animation!")
        
        let moveRight = InterpolationAction(from: CGPoint(x: 10, y: 10),
                                            to: CGPoint(x: 200, y: 10),
                                            duration: 3) {
                                                self.testView.frame.origin = $0
                                                
                                                if self.testView.frame.origin.x > 190 {
                                                    print("stop")
                                                }
        }
        
        let scale = InterpolationAction(from: CGSize(width: 30, height: 30),
                                        to: CGSize(width: 100, height: 100),
                                        duration: 2) {
            self.testView.frame.size = $0
        }
        
        let group = Group(actions: moveRight, scale).yoyo().repeated(2)
        let animation = Animation(action: group)
        animation.run()
    }
 */

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layout Slider
        slider.sizeToFit()
        let margin = CGFloat(5)
        slider.frame = CGRect(x: margin,
                              y: view.bounds.size.height - slider.bounds.size.height - 30,
                              width: view.bounds.size.width - (margin * 2),
                              height: slider.bounds.size.height);
    }
    
    // MARK: - Slider callback
    func sliderValueChanged() {
        print("Slider value changed")
    }
   
}
