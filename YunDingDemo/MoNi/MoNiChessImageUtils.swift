//
//  MoNiChessImageUtils.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/24.
//

import Foundation
import UIKit


class showHeroImagesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var qiPanViewController: QiPanViewController?
    
    var names: [String] = []
    var images: [UIImage] = []
    
    private var collectionView: UICollectionView!
    
    func showHeroImages(_ images: [UIImage], in view: UIView, names: [String]) {
        self.images = images
        self.names = names
        
        // 移除之前的 UICollectionView
        collectionView?.removeFromSuperview()
        
        // 创建 UICollectionViewFlowLayout 实例，设置为垂直方向布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 20.0
        
        // 创建 UICollectionView 实例
        let collectionViewFrame = CGRect(x: 0, y: 350, width: view.bounds.width, height: view.bounds.height - 370)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        
        // 设置 dataSource 和 delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 UICollectionViewCell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // 设置背景颜色和滚动条
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false // 禁用滚动条
        
        // 将 UICollectionView 添加到父视图
        view.addSubview(collectionView)
    }
    
    // UICollectionViewDataSource 方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: scaledSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // 移除之前的 UIImageView
        for subview in cell.contentView.subviews {
            if let imageView = subview as? UIImageView {
                imageView.removeFromSuperview()
            }
        }
        
        let image = images[indexPath.item]
        let resizedImage = resizeImage(image, targetSize: CGSize(width: 50, height: 50)) // 调整图片尺寸为 50x50
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60)) // 设置固定的大小
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 方法
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 计算每个 item 的大小，根据每行显示的图片数量和间距动态调整
        return CGSize(width: 60, height: 60)
    }
    
    // UICollectionViewDelegate 方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = names[indexPath.item]
        qiPanViewController?.changeImage(with: name)
    }
    
}
