//
//  GradientView.swift
//  memorybank
//
//  Created by Benjamin Turner on 11/4/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor(hue: 0, saturation: 0.01, brightness: 0.57, alpha: 1.0){
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor(hue: 0.5667, saturation: 0.61, brightness: 0.23, alpha: 1.0){
        didSet {
            updateView()
        }
    }

    @IBInspectable var isHorizontal: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
        if (isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
    
}
