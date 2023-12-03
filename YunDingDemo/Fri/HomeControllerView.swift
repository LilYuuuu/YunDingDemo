//
//  HomeControllerViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/17.
//

import UIKit

let dispatchGroup = DispatchGroup()

class HomeControllerView: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchGroup.enter()
        receiveChess()
        
        dispatchGroup.enter()
        receiveCity()
        
        dispatchGroup.enter()
        receiveJob()
        
        dispatchGroup.enter()
        receiveCityNum()
        
        dispatchGroup.enter()
        receiveJobNum()
        
        dispatchGroup.enter()
        receiveLineup()
        
        dispatchGroup.enter()
        receiveLineupN()
        
        
        dispatchGroup.notify(queue: .main){
            countLineupAttr()
            
            self.tabBar.frame.size.height = 40
            
            // 创建三个视图控制器
            let viewController1 = HomeViewController()
            viewController1.tabBarItem = UITabBarItem(title: "首页", image: nil, tag: 0)
            
            let viewController2 = UINavigationController(rootViewController: LilYuuTableViewController())
            //        let viewController2 = LilYuuTableViewController()
            viewController2.tabBarItem = UITabBarItem(title: "阵容", image: nil, tag: 1)
            
            let viewController3 = MoNiViewController()
            viewController3.tabBarItem = UITabBarItem(title: "模拟", image: nil, tag: 2)
            
            // 创建一个字典来设置标题的属性，比如字体、颜色等
            let attributes =  [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
            let attributes1 = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
            let attributes2 = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
            
            // 使用 NSAttributedString 将属性应用到标题上
            viewController2.tabBarItem.setTitleTextAttributes(attributes1, for: .normal)
            viewController3.tabBarItem.setTitleTextAttributes(attributes2,for: .normal)
            viewController1.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
            
            
            // 设置UITabBarController的viewControllers属性为上述两个视图控制器
            self.viewControllers = [viewController1, viewController2,viewController3]
        }
    }
    

}
