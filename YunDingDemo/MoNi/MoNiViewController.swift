//
//  MoNiViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/23.
//

import UIKit
  
class MoNiViewController: UIViewController{
    
    
    let buttonPadding: CGFloat = 10 // 按钮之间的间距
    
    var customView = CustomView() //文字视图
    
    
    let heroImagesController = showHeroImagesController()
    var qiPanViewController: QiPanViewController = QiPanViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroImagesController.qiPanViewController = qiPanViewController
        qiPanViewController.customView = customView
        
        createButtonsCity()
        createButtonsJob()
        displayCityAndJob(qiPanVC: qiPanViewController)
//        displayTextView()
        
//        displayChildViewController(qiPanVC: qiPanViewController)
        
    }
    
    func createButtonsCity() {
        
        var currentY: CGFloat = 100
        var currentX: CGFloat = 20
        
        guard let buttonTitles = cities else {
                return
        }
            
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title.name, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            button.sizeToFit()
            
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.gray, for: .highlighted)
            button.setTitleColor(.gray, for: [.highlighted, .selected])
            button.setBackgroundImage(UIImage(named: "normal_background"), for: .normal)
            button.setBackgroundImage(UIImage(named: "highlighted_background"), for: .highlighted)
            button.setBackgroundImage(UIImage(named: "highlighted_background"), for: [.highlighted, .selected])
                
            // 如果当前按钮放置在当前行会导致超出屏幕宽度，则需要换行
            if currentX + button.frame.size.width > view.frame.size.width - buttonPadding {
                // 重置 x 坐标到起始位置
                currentX = 20
                // 更新 y 坐标到下一行的顶部
                currentY += button.frame.size.height + buttonPadding
            }
                
            button.frame = CGRect(x: currentX, y: currentY, width: button.frame.size.width, height: button.frame.size.height)
            currentX += button.frame.size.width + buttonPadding
                
            button.addTarget(self, action: #selector(buttonClickedCity(_:)), for: .touchUpInside)
                
            view.addSubview(button)
        }
    }
    
    func createButtonsJob() {
        
        var currentY: CGFloat = 230
        var currentX: CGFloat = 20
        
        guard let buttonTitles = jobs else {
                return
        }
            
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title.name, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            button.sizeToFit()
            
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.gray, for: .highlighted)
            button.setTitleColor(.gray, for: [.highlighted, .selected])
            button.setBackgroundImage(UIImage(named: "normal_background"), for: .normal)
            button.setBackgroundImage(UIImage(named: "highlighted_background"), for: .highlighted)
            button.setBackgroundImage(UIImage(named: "highlighted_background"), for: [.highlighted, .selected])
                
            // 如果当前按钮放置在当前行会导致超出屏幕宽度，则需要换行
            if currentX + button.frame.size.width > view.frame.size.width - buttonPadding {
                // 重置 x 坐标到起始位置
                currentX = 20
                // 更新 y 坐标到下一行的顶部
                currentY += button.frame.size.height + buttonPadding
            }
                
            button.frame = CGRect(x: currentX, y: currentY, width: button.frame.size.width, height: button.frame.size.height)
            currentX += button.frame.size.width + buttonPadding
                
            button.addTarget(self, action: #selector(buttonClickedJob(_:)), for: .touchUpInside)
                
            view.addSubview(button)
        }
    }
        
    @objc func buttonClickedCity(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            print("Clicked button: \(title)")
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    button.isSelected = false
                }
            }
            sender.isSelected = true
            
            
            guard let jobHero = heroes else {
                    return
            }
            
            let fighters = jobHero.filter { hero in
                hero.cities.contains { city in
                    city.name == title
                }
            }
            
            for fighter in fighters {
                print("Fighter name: \(fighter.name)")
            }
            
            // 添加英雄图片到一个新的数组
            var heroImages = [UIImage]()
            var heroNames = [String]()
            for fighter in fighters {
                if let image = UIImage(named: fighter.name) {
                    heroImages.append(image)
                    heroNames.append(fighter.name)
                }
            }
            
            // 显示英雄图片
            heroImagesController.showHeroImages(heroImages, in: view, names: heroNames)
            displayChildViewController(qiPanVC: qiPanViewController)
        }
    }
    
    @objc func buttonClickedJob(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            print("Clicked button: \(title)")
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    button.isSelected = false
                }
            }
            sender.isSelected = true
            
            guard let jobHero = heroes else {
                    return
            }
            
            let fighters = jobHero.filter { hero in
                hero.jobs.contains { job in
                    job.name == title
                }
            }
            
            for fighter in fighters {
                print("Fighter name: \(fighter.name)")
            }
            
            // 添加英雄图片到一个新的数组
            var heroImages = [UIImage]()
            var heroNames = [String]()
            for fighter in fighters {
                if let image = UIImage(named: fighter.name) {
                    heroImages.append(image)
                    heroNames.append(fighter.name)
                }
            }
            
            // 显示英雄图片
            heroImagesController.showHeroImages(heroImages, in: view, names: heroNames)
            displayChildViewController(qiPanVC: qiPanViewController)
        }
    }
    
//    创建模拟棋盘
    func displayChildViewController(qiPanVC: QiPanViewController) {
        // 添加QiPanViewController为子视图控制器
        addChild(qiPanVC)
        
        // 创建包含两个子视图的父视图
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // 将QiPanViewController的视图添加到父视图中
        view.addSubview(qiPanVC.view)
        
        // 设置QiPanViewController的视图约束
        qiPanVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            qiPanVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            qiPanVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            qiPanVC.view.widthAnchor.constraint(equalToConstant: 200),
            qiPanVC.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // 设置containerView的约束
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // 完成添加子视图控制器的过程
        qiPanVC.didMove(toParent: self)
    }
    
//    创建羁绊显示
    func displayCityAndJob(qiPanVC: QiPanViewController){
        customView.frame = CGRect(x: 0, y: 660, width: view.bounds.width, height: 200)
        customView.changeJobOrCity()
        view.addSubview(customView)
    }
    
//    羁绊变动
}
    

