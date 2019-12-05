//
//  tabBarExtensions.swift
//  memorybank
//
//  Created by David Sun on 12/4/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 104
        return sizeThatFits
    }    
}

extension UITabBarItem {
    
}
