//
//  HomeViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.center = view.center

        // 设置图片
        let image = UIImage(named: "home") // 替换为你的图片名称
        imageView.image = image

        // 设置其他属性
        imageView.contentMode = .scaleAspectFit
        
        //设置圆角
        imageView.layer.cornerRadius = 100 // 设置为圆角半径的值
        imageView.layer.masksToBounds = true
        // 开启masksToBounds以显示圆角效果

        // 添加到视图中
        view.addSubview(imageView)
        
    }
    

}
