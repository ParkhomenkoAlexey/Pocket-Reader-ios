//
//  StackView + Extension.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 30.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubview: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubview)
        self.axis = axis
        self.spacing = spacing
    }
    
}
