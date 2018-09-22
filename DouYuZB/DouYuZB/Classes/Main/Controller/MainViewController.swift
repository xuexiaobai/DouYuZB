//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        self.tabBar.tintColor = UIColor.orange;
    }
    
    fileprivate func addChildVC(_ storyName: String) {
        //1.通过Storyboard获取控制器
        let childVC = StoryboardHelper.initializeViewController(stroryboardName: storyName)
        //2.将childVC作为字控制器
        addChildViewController(childVC)
    }

}
