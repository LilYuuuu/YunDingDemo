//
//  TextView.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/30.
//


import UIKit

class CustomView: UIView {
    var data: [String: Int] = [:] {
        didSet {
            setupButtons()
        }
    }
    
    private let buttonHeight: CGFloat = 35
    private let buttonSpacing: CGFloat = 0
    
    func setupButtons() {
        subviews.forEach { $0.removeFromSuperview() }
        
        var x: CGFloat = 20
        var y: CGFloat = 10
        var buttonCount = 0
        
        let data = data.sorted { $0.value > $1.value }
        
        for (key, value) in data {
            
            let c = helper(key,value)
            
            let formattedString = "\(c)\(key)(\(value))"
            
            let button = UIButton(type: .system)
            button.setTitle(formattedString, for: .normal)
            button.sizeToFit()
            
            button.setTitleColor(.white, for: .normal)
            
            let buttonWidth = button.frame.width + 10 // 调整按钮宽度
            let availableWidth = frame.width - 40 // 减去左右边距
            
            if x + buttonWidth > availableWidth {
                x = 20
                y += buttonHeight + buttonSpacing
            }
            
            button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
            
            // 添加边框和圆角
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
            
            addSubview(button)
            
            x += buttonWidth + buttonSpacing
            buttonCount += 1
        }
    }
    
    // 羁绊变动
    func changeJobOrCity() {
        data = selectedChess
    }
}
