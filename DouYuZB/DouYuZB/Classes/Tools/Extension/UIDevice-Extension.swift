//
//  UIDevice-Extension.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/23.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isiPhoneX() -> Bool {
        if kScreenW == 375 && kScreenH == 812 {
            return true
        }
        return false
    }
}

