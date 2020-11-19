//
//  ViewController.swift
//  animationChallenge
//
//  Created by Rudolf Oganesyan on 19.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    var inEditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        inEditMode.toggle()
        if inEditMode {
            startWiggling()
        } else {
            stopWiggling()
        }
    }
    
    private func startWiggling() {
        guard button.layer.animation(forKey: "groupAnimation") == nil else { return }
        
        let angle: CGFloat = 18 * .pi / 180
        
        let rotate = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotate.values = [-angle, 0, angle]
        rotate.autoreverses = true
        rotate.duration = 0.15
        rotate.keyTimes = [0, 0.5, 1]
        rotate.repeatCount = Float.infinity
        
        let jump = CAKeyframeAnimation(keyPath: "transform.translation.y")
        jump.values = [0, 5.0, 0.0, -5.0]
        jump.autoreverses = true
        jump.duration = 0.15
        jump.keyTimes = [0, 0.4, 0.8, 1.0]
        jump.repeatCount = Float.infinity
        
        let move = CAKeyframeAnimation(keyPath: "transform.translation.x")
        move.values = [0, 5.0, 0.0, -5.0]
        move.autoreverses = true
        move.duration = 0.15
        move.keyTimes = [0, 0.4, 0.8, 1.0]
        move.repeatCount = Float.infinity
        
        let group = CAAnimationGroup()
        group.duration = 0.3
        group.repeatCount = .infinity
        group.autoreverses = true
        group.animations = [rotate, jump, move]
        button.layer.add(group, forKey: "groupAnimation")
    }
    
    private func stopWiggling() {
        button.layer.removeAllAnimations()
        self.button.transform = CGAffineTransform.identity
    }
}
