//
//  QiPanViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/24.
//

import UIKit

var addedImages: [String] = []

class QiPanViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var customView : CustomView?
    
    var buttons = [UIButton]() // 保存按钮的数组
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建包含9个按钮的数组
        for _ in 0..<9 {
            let button = UIButton()
            button.backgroundColor = UIColor.black // 设置按钮背景颜色以便区分
            button.translatesAutoresizingMaskIntoConstraints = false // 禁用自动布局
            view.addSubview(button) // 将按钮添加到视图中
            buttons.append(button)
            
            // 给按钮添加点击事件
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        // 使用约束将按钮排列成九宫格
        for i in 0..<3 {
            for j in 0..<3 {
                let button = buttons[i * 3 + j]
                button.widthAnchor.constraint(equalToConstant: 50).isActive = true // 设置按钮宽度为50
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true // 设置按钮高度为50
                if i == 0 {
                    button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true // 第一行按钮的顶部约束
                } else {
                    button.topAnchor.constraint(equalTo: buttons[(i - 1) * 3 + j].bottomAnchor, constant: 10).isActive = true // 其他行按钮的顶部约束
                }
                if j == 0 {
                    button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true // 第一列按钮的左侧约束
                } else {
                    button.leftAnchor.constraint(equalTo: buttons[i * 3 + j - 1].rightAnchor, constant: 10).isActive = true // 其他列按钮的左侧约束
                }
            }
        }
    }
    
//    点击显示出来的棋子事件
    func changeImage(with image: String) {
        
        // 检查图片是否已经存在
        if addedImages.contains(image) {
            print("图片 '\(image)' 已经存在，无需重复添加。")
            return
        }
        
        // 遍历所有按钮，寻找第一个没有设置图片的按钮
        for button in buttons {
            if button.image(for: .normal) == nil {
                button.setImage(UIImage(named: image), for: .normal)
                addSelectedChess(image)
                addedImages.append(image)
                button.accessibilityIdentifier = "\(image)"
                break
            }
        }
        print(addedImages)
        customView?.changeJobOrCity()
    }
    
    func deleteImage(for index: Int){
        let button = buttons[index]
        button.setImage(nil, for: .normal)
    }
    
//    点击事件
    @objc func buttonTapped(_ sender: UIButton) {
        
        guard let image = sender.image(for: .normal) else {
            print("111")
            return
        }
        
        let imageName = sender.accessibilityIdentifier
        addedImages.removeAll { $0 == imageName }
        
        reduceSelectedChess(imageName!)
        print(addedImages)
        customView?.changeJobOrCity()
        
        print("buttonTapped")
        sender.setImage(nil, for: .normal)
        
    }
}

