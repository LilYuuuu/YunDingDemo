//
//  ZhenRongViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/23.
//

import UIKit

class ZhenRongViewController: UIViewController {
    
    var selectedZhenRong: String?
    var comId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchGroup.enter()
        receiveLineupChess(comId!)
        
        
        
        dispatchGroup.notify(queue: .main){ [self] in
            if let zhenRong = self.selectedZhenRong {
                DispatchQueue.main.async {
                    self.title = zhenRong // 设置视图控制器的标题为人员姓名
                }
            }
            
            var lineupImage = LineupImage()
            let lineupImageViewController = lineupImage

            lineupImageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(lineupImageViewController.view)

            // 添加 Autolayout 约束
            
            lineupImageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            lineupImageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            lineupImageViewController.view.heightAnchor.constraint(equalToConstant: 420).isActive = true
            lineupImageViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

            self.addChild(lineupImageViewController)
            lineupImageViewController.didMove(toParent: self)
            
            
            
            let label = UILabel()
            
            
            label.text = "\(Lineups![comId!-1].Content)"
            
            label.font = UIFont.systemFont(ofSize: 16) // 设置字体大小
            label.textColor = UIColor.white // 设置文字颜色
            label.numberOfLines = 0 // 允许多行显示
            label.lineBreakMode = .byWordWrapping // 设置换行模式为单词换行
            
//            设置位置和代销
            label.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 200)
            // 将标签添加到视图层级中
            view.addSubview(label)
        }
    }
    
    
}
