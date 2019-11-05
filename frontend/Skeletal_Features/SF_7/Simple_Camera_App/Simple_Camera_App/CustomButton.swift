//
//  CustomButton.swift
//  Simple_Camera_App
//
//  Created by Benjamin Turner on 11/4/19.
//  Copyright © 2019 Stewart Vohra. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        backgroundColor      = UIColor(hue: 0.525, saturation: 0.99, brightness: 0.81, alpha: 1.0)
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 24)
        layer.cornerRadius   = 25
        layer.borderWidth    = 3.0
        layer.borderColor    = UIColor.white.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 4
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}
