//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    // MARK:懒加载TitleView
    private lazy var pageTitleView : PageTitleView = {
        let titles = ["推荐","游戏","娱乐","旅游"]
        let pageTitleView = PageTitleView(frame: CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH), titles: titles)
        return pageTitleView
    }()
    // MARK:懒加载ContentView
    private lazy var pageContentView : PageContentView = {[weak self] in
        //1.获取Content位置、大小
        let contentH = kScreenH - kTopBarH - kTitleViewH - kBottomH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kTopBarH + kTitleViewH, width: kScreenW, height: contentH)
        //2.生成ChildViewControllers
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(viewController)
        }
        //3.实例化ContentView
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        return pageContentView
    }()
    // MARK:系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension HomeViewController {
    private func setupUI() {
        //0.不要添加内边距
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        //1.导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
        //3.添加ContentView
        view.addSubview(pageContentView)
    }
    // MARK:创建NavigationBar
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let btnSize = CGSize(width: 40, height: 40)
        
        //类方法创建
//        let historyItem = UIBarButtonItem.createImage(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: btnSize)
//        let searchItem = UIBarButtonItem.createImage(imageName: "btn_search", hightImageName: "btn_search_clicked", size: btnSize)
//        let qrCodeItem = UIBarButtonItem.createImage(imageName: "Image_scan", hightImageName: "Image_scan_click", size: btnSize)
        
        //构造函数创建
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: btnSize)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: btnSize)
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: btnSize)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
    }
}
