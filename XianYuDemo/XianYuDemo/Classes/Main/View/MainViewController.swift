//
//  MainViewController.swift
//  XianYuDemo
//
//  Created by Enrica on 2017/10/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}


// MARK: - 设置UI界面
extension MainViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 一次性添加所有的子控制器
        addChildViewControllers()
        
        // 自定义tabBar
        let tabBar = TabBar()
        self.setValue(tabBar, forKeyPath: "tabBar")
    }
    
    /// 一次性添加所有的子控制器
    private func addChildViewControllers() {
        
        // 分别添加各子控制器
        addChildViewController(HomeViewController(), title: "首页", imageName: "home")
        addChildViewController(FishpondViewController(), title: "鱼塘", imageName: "fishpond")
        // addChildViewController(UIViewController())  // 占位控制器
        addChildViewController(MessageViewController(), title: "消息", imageName: "message")
        addChildViewController(AccountViewController(), title: "我的", imageName: "account")
    }
    
    /// 添加单个子控制器
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        
        // 设置子控制器的标题
        childController.title = title
        
        // 设置子控制器tabBarItem的图片
        childController.tabBarItem.image = UIImage(named: imageName + "_normal")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlight")?.withRenderingMode(.alwaysOriginal)
        
        // 设置子控制器tabBarItem字体的颜色
        var textColor: [String: Any] = Dictionary()
        textColor[NSForegroundColorAttributeName] = UIColor.black
        childController.tabBarItem.setTitleTextAttributes(textColor, for: .selected)
        
        // 设置子控制器tabBarItem字体的大小
        var textFont: [String: Any] = Dictionary()
        textFont[NSFontAttributeName] = UIFont.systemFont(ofSize: 9)
        childController.tabBarItem.setTitleTextAttributes(textFont, for: .normal)
        
        // 将子控制器包装成导航控制器
        let nav = UINavigationController(rootViewController: childController)
        
        // 将导航控制器添加到父控制器中
        addChildViewController(nav)
    }
}
