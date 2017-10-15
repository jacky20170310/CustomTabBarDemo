//
//  TabBar.swift
//  XianYuDemo
//
//  Created by Enrica on 2017/10/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    
    // MARK: - 懒加载属性

    /// 中间的发布按钮
    fileprivate lazy var postButton: Button = {
        
        // 设置中间发布按钮的背景图片
        let postButton = Button(imageName: "post_normal")
        
        return postButton
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension TabBar {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置tabBar的背景图片
        backgroundImage = UIImage(named: "tabbar_bg")
    
        
        // 添加post按钮
        setupPostButton()
    }
    
    
    /// 添加中间的发布按钮
    private func setupPostButton() {
        
        // 将按钮添加到tabBar上面
        addSubview(postButton)
        
        // 设置发布按钮的文字
        postButton.setTitle("发布", for: .normal)
        
        // 设置发布按钮文字的颜色
        postButton.setTitleColor(.darkGray, for: .normal)
        
        // 设置发布按钮文字字体大小
        postButton.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        
        // 设置按钮文字居中显示
        postButton.titleLabel?.textAlignment = .center
        
        // 监听中间发布按钮的点击
        postButton.addTarget(self, action: #selector(TabBar.postButtonClick), for: .touchUpInside)
    }
    
    
    /// 调整子控件的位置，或者设置子空间的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 用于存储按钮
        var tabBarButtonArr = [Any]()
        
        // 遍历tabBar的子控件
        for subView in self.subviews {
            
            // 将所有UITabBarButton存放到数组中
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabBarButtonArr.append(subView)
            }
        }
        
        // 获取tabBar的宽度和高度
        let tabBarWidth: CGFloat = self.bounds.size.width
        let tabBarHeight: CGFloat = self.bounds.size.height
        
        // 获取发布按钮的宽度和高度
        let postButtonWidth: CGFloat = postButton.frame.width
        
        // 重新布局postButton的位置
        postButton.center = CGPoint(x: tabBarWidth * 0.5, y: tabBarHeight * 0.2)
        
        // 计算tabBarButton的宽度
        let tabBarButtonWidth: CGFloat = (tabBarWidth - postButtonWidth) / CGFloat(tabBarButtonArr.count)
        
        // 遍历tabBarButtonArr，取出里面的tabBarButton和与之对应的index
        for (index, subview) in tabBarButtonArr.enumerated() {
            
            // 取出subview的frame
            var subviewFrame = (subview as! UIView).frame
            
            if index >= tabBarButtonArr.count / 2 {
                
                // 设置下标为2和3的tabBarButton的x值
                subviewFrame.origin.x = CGFloat(index) * tabBarButtonWidth + postButtonWidth
            } else {
                
                // 设置下标为0和1的tabBarButton的x值
                subviewFrame.origin.x = CGFloat(index) * tabBarButtonWidth
            }
            
            // 设置tabBarButton的宽度
            subviewFrame.size.width = tabBarButtonWidth
            
            // 重写设置tabBarButton的frame
            (subview as! UIView).frame = subviewFrame
        }
        
        // 将发布按钮移动到最上面
        bringSubview(toFront: postButton)
    }
    
    
    
    /// 重写hitTest(_ : , with : )方法，让超出tabBar部分也能响应事件
    /// - 如果父控件不能接收触摸事件，那么子控件就不可能接收触摸事件
    /// - 返回的是谁，谁就是最适合处理事件的View
    /// - hitTest(_ : , with : )方法会被调用两次
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        // 调用父控件的hitTest(_ : , with : )方法
        var result = super.hitTest(point, with: event)
        
        // 如果控件不可交互、控件被隐藏，或者控件是透明的，则表示不能处理事件(控件不交互的三种情况)
        if self.isUserInteractionEnabled == false || self.isHidden == true || self.alpha <= 0.01 {
            return nil
        }
        
        // 当result可以处理事件时，返回result
        if (result != nil) { return result }
        
        // 遍历tabBar的子空间
        for subview in subviews {
            
            // 把这个坐标从tabBar的坐标系转为postButton的坐标系
            let subPoint: CGPoint = subview.convert(point, from: self)
            
            // 调用子控件，也就是postButton的hitTest(_ : , with : )方法
            result = subview.hitTest(subPoint, with: event)
            
            // 如果事件发生在subview里就返回result
            if (result != nil) {
                return result
            }
        }
        
        return nil
    }
}




// MARK: - 监听按钮的点击
extension TabBar {
    
    /// 监听中间发布按钮的点击
    @objc fileprivate func postButtonClick() {
        
        print("postButtonClick")
    }
}
