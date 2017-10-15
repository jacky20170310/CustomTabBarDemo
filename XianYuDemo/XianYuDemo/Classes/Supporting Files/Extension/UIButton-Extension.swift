//
//  UIButton-Extension.swift
//  XianYuDemo
//
//  Created by Enrica on 2017/10/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 根据给定的图片自定义按钮
    /// - 参数imageName: 表示普通状态下按钮的图片
    /// - 参数backgroundImageName: 表示高亮状态下按钮的图片
    convenience init(imageName: String, backgroundImageName: String = "") {
        
        self.init()
        
        
        // 设置按钮的图片
        setImage(UIImage(named: imageName), for: .normal)
        
        
        // 设置按钮的背景图片
        setBackgroundImage(UIImage(named: backgroundImageName), for: .highlighted)
        
        // 设置按钮的尺寸
        //sizeToFit()
    }
}
