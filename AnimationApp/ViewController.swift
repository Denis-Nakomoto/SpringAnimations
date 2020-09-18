//
//  ViewController.swift
//  AnimationApp
//
//  Created by Denis Svetlakov on 17.09.2020.
//

import Spring

class ViewController: UIViewController {
    
    @IBOutlet weak var animationView: SpringView!
    
    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet weak var curveLabel: UILabel!
    @IBOutlet weak var forceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    
    private var rndAnimation: String!
    private var rndCurve: String!
    private var rndForce: CGFloat!
    private var rndDuration: CGFloat!
    private var rndVelocity: CGFloat!
    private var counter = 0
    private var currentAnimationParams: [String:Any]!
    private var nextAnimationParams: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentAnimationParams = currentAnimation()
    }
    
    private func randomizeAnimations() -> String {
        var array = [String]()
        for element in Spring.AnimationPreset.allCases {
            array.append(element.rawValue)
        }
        return array.randomElement()!
    }
    
    private func randomizeCurves() -> String {
        var array = [String]()
        for element in Spring.AnimationCurve.allCases {
            array.append(element.rawValue)
        }
        return array.randomElement()!
    }
    
    private func currentAnimation() -> [String:Any] {
        var result:[String:Any] = [:]
        let keys = ["rndAnimation", "rndCurve", "rndForce", "rndDuration", "rndVelocity"]
        let values: [Any] = [randomizeAnimations(),
                             randomizeCurves(),
                             CGFloat.random(in: 0.3 ... 2.0),
                             CGFloat.random(in: 1 ... 3.0),
                             CGFloat.random(in: 0.3 ... 2.0)]
       
        for (key, value) in zip(keys, values) {
            result[key] = value
        }
        return result
    }
    
    private func extractValues(_ dict:[String:Any]) {
        rndAnimation = dict["rndAnimation"] as? String
        rndCurve = dict["rndCurve"] as? String
        rndForce = dict["rndForce"] as? CGFloat
        rndDuration = dict["rndDuration"] as? CGFloat
        rndVelocity = dict["rndVelocity"] as? CGFloat
    }
    
    private func setLabels() {
        animationLabel.text = rndAnimation
        curveLabel.text = rndCurve
        forceLabel.text = String(format: "%.2f", rndForce)
        durationLabel.text = String(format: "%.2f", rndDuration)
        velocityLabel.text = String(format: "%.2f", rndVelocity)
    }
    
    private func animate(_ dict: [String: Any]) {
        extractValues(dict)
        setLabels()
        animationView.animation = rndAnimation
        animationView.curve = rndCurve
        animationView.force = rndForce
        animationView.duration = rndDuration
        animationView.velocity = rndVelocity
        animationView.animate()
    }
    
    @IBAction func runAnimationPressed(_ sender: SpringButton) {
        if counter % 2 == 0  {
            animate(currentAnimationParams)
            nextAnimationParams = currentAnimation()
            sender.setTitle(nextAnimationParams["rndAnimation"] as? String, for: .normal)
            counter += 1
        } else {
            animate(nextAnimationParams)
            currentAnimationParams = currentAnimation()
            sender.setTitle(currentAnimationParams["rndAnimation"] as? String, for: .normal)
            counter += 1
        }
    }
}
