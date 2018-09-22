//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //第一种方式.扩展类方法
    class func createImage(imageName: String, hightImageName: String, size :CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    //第二种方式 构造函数
    //便利构造函数 1.convenience开头 2.必须调用一个设计的构造函数（self调用）
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero) {
        //1.创建Button
        let btn = UIButton()
        //2.设置图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        //3.设置尺寸
        if size != .zero {
            btn.frame = CGRect(origin: .zero, size: size)
        } else {
            btn.sizeToFit()
        }
        //4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
