//
//  ViewController.swift
//  UIKit_Maraton_3
//
//  Created by user228564 on 3/9/23.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider()
    let myView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sliderAdd()
        viewAdd()
    }
    
    func sliderAdd() {
        view.addSubview(slider)
        
        slider.addTarget(self, action: #selector(viewTransform), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderMove), for: .touchUpInside)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -80)
        ])
    }
    
    func viewAdd() {
        view.addSubview(myView)
        
        myView.backgroundColor = .systemGreen
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = true
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -220),
            myView.widthAnchor.constraint(equalToConstant: 80),
            myView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func viewTransform() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [self] in
            
            let scaling = CGAffineTransform(scaleX: 1 + CGFloat(slider.value / 2 ), y: 1 + CGFloat(slider.value / 2))
            let rotation = CGAffineTransform(rotationAngle: (.pi / 2) * CGFloat(slider.value))
            let moving = CGAffineTransform(translationX: 0 + (CGFloat(slider.value) * (view.frame.width - myView.frame.width - 10)), y: 0)
            
            myView.transform = CGAffineTransformConcat(CGAffineTransformConcat(scaling, rotation), moving)
        })
    }
    
    @objc func sliderMove() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
            if slider.value < slider.maximumValue {
                slider.setValue(slider.value + 0.01, animated: true)
                viewTransform()
            } else {
                timer.invalidate()
            }
        }
    }
    
}
