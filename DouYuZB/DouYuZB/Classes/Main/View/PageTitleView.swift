//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2
private let kBottomLineH : CGFloat = 0.5

class PageTitleView: UIView {
    // MARK:定义属性
    private var titles : [String]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    // MARK:定义ScrollView 闭包
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    // MARK:定义滑块View 闭包
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    // MARK:初始化方法
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    private func setupUI() {
        //0.设置ScrollView
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        //1.添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加添加标签
        setupTitleLabels()
        //3.添加底线和滑动View
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建Label
            let label = UILabel()
            //2.设置label属性
            label.text = title
            label.textColor = UIColor.black
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            //3.设置位置、大小
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.添加Label
            scrollView.addSubview(label)
            //5.label添加到数组中
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - kBottomLineH, width: frame.width, height: kBottomLineH)
        addSubview(bottomLine)
        //2.滑块View
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}
