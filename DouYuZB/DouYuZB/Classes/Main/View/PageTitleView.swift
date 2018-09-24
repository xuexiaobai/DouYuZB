//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/22.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit
// MARK:设置变量
private let kScrollLineH : CGFloat = 2
private let kBottomLineH : CGFloat = 0.5
private let kNormalColor : (CGFloat , CGFloat , CGFloat) = (51, 51, 51)
private let kSelectedColor : (CGFloat , CGFloat, CGFloat) = (256, 128, 0)
// MARK:设置代理
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}
// MARK:设置PageTitleView类
class PageTitleView: UIView {
    // MARK:定义属性
    private var currentLabelIndex : Int = 0
    private var titles : [String]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    // MARK:代理属性
    weak var delegate : PageTitleViewDelegate?
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

// MARK:设置UI
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
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
            //6.添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

// MARK:Label的点击事件
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        //1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //2.获取之前的Label
        let oldLabel = titleLabels[currentLabelIndex];
        //3.更新当前的Index
        currentLabelIndex = currentLabel.tag
        //4.修改颜色
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        //5.修改滑块的位置
        let scrollLineX = CGFloat(currentLabelIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.设置代理方法
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
    }
}

// MARK:对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //1.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //2.处理渐变颜色
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //3.更新当前Label的Index
        currentLabelIndex = targetIndex
    }
}
