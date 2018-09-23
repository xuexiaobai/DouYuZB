//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

private let kContentCollectionID = "contentCollectionID"

class PageContentView: UIView {

    // MARK:设置属性
    private var childVCs : [UIViewController]
    private weak var parentViewController : UIViewController?
    // MARK:懒加载CollectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建CollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCollectionID)
        
        return collectionView
    }()
    // MARK:初始化
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    // MARK:设置UI
    private func setupUI() {
        //1.将所有自控制器放到主控制器里面
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        //2.CollectionView加载设置大小
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取Cell
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kContentCollectionID, for: indexPath)
        //2.清除内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        //3.设置Cell
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK:对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        //第一种方法.设置偏移量
//        let contentOffsetX = CGFloat(currentIndex) * collectionView.frame.width
//        collectionView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: false)
        //第二种方法.滚动到指定位置
        let indexPath = NSIndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: false)
        
    }
}
