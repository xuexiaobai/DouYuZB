//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension HomeViewController {
    private func setupUI() {
        setupNavigationBar()
    }
    
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
