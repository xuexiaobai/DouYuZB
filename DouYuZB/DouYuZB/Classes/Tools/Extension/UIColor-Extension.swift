//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/23.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b  / 255.0, alpha: a)
    }
}
