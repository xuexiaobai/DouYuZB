//
//  StoryboardHelper.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

class StoryboardHelper: NSObject {
    
    class func viewController(stroryBoardName:String, identifier:String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: stroryBoardName, bundle: nil);
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    class func initializeViewController(stroryboardName: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: stroryboardName, bundle: nil);
        return storyboard.instantiateInitialViewController()!
        
    }

}
