//
//  Button.swift
//  XianYuDemo
//
//  Created by Enrica on 2017/10/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置发布按钮中imageView的frame
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width - 2)
    }
    
    
    // 设置发布按钮中label的frame
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.bounds.height - self.bounds.width)
    }
}


// MARK: - 设置UI界面
extension Button {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 去掉按钮点击时置灰效果
        adjustsImageWhenHighlighted = false
        
        // 设置按钮的frame
        frame = CGRect(x: 0, y: 0, width: 52, height: 59)
    }
}
