//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/24.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

// MARK:设置变量
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderH : CGFloat = 44

private let kSection = 12
private let kFirstSectionItem = 8
private let kSectionItem = 4

private let kNormalCellID = "kNormalCellID"
private let kHeaderID = "kHeaderID"

class RecommendViewController: UIViewController {
    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1.设置Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        //设置CollectionView的组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        //2.初始化CollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        //3.设置代理
        collectionView.dataSource = self
        //4.注册Cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //5.注册Header
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionView
    }()
    
    
    // MARK:ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}

// MARK:设置UI界面
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        //CollectionView的宽度、高度，随着父控件的大小变化
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}

// MARK:遵守UICollectionViewDataSource协议
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kSection
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return kFirstSectionItem
        }
        return kSectionItem
    }
    //设置Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    //每组的头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        headerView.backgroundColor = UIColor.yellow
        return headerView
    }
}


