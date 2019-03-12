//
//  XGImageCacheManager.swift
//  weibo
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SDWebImage

class XGImageCacheManager: NSObject
{
    /// 单例
    public static var shared:XGImageCacheManager = XGImageCacheManager()
    
    /// 图片缓存数组
    private var imageCacheDictioary = [String:UIImage]()
    
    // MARK: - 构造方法
    
    private override init()
    {
        super.init()
        // 注册内存警告通知
        NotificationCenter.default.addObserver(self, selector: #selector(removeCache), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 图片缓存

extension XGImageCacheManager
{
    /// 根据图片url返回渲染后的图片
    ///
    /// - Parameters:
    ///   - key: 图片url
    ///   - size: 图片尺寸
    ///   - backgroundColor: 背景色 默认白色
    ///   - isUserIcon: 是否是用户头像(进行圆角处理) 默认false
    ///   - isLongPicture: 是否是长图(进行裁剪处理) 默认false
    ///   - completion: 完成回调
    open func imageForKey(key:String?,size:CGSize,backgroundColor:UIColor = UIColor.white,isUserIcon:Bool = false,isLongPicture:Bool = false, completion:@escaping (UIImage?) -> Void) -> Void
    {
        guard let key = key else {
            completion(nil)
            return
        }
        
        // 如果已经缓存了 直接返回
        if imageCacheDictioary[key] != nil {
            completion(imageCacheDictioary[key])
            return
        }
        
        // 图片不存在 进行下载
        SDWebImageManager.shared().loadImage(with: URL(string: key), options: [.retryFailed,.refreshCached], progress: nil) { (image, _, error, _, _, _) in
            if image == nil || error != nil {
                completion(nil)
                return
            }
            
            // 进行图片处理
            var newImage:UIImage?
            if isUserIcon {
                newImage = image?.circleIconImage(imageSize: size, backgroundColor: backgroundColor)
            } else if isLongPicture {
                newImage = self.clipImage(sourceImage: image!, imageSize: size, backgroundColor: backgroundColor)
            } else {
                newImage = image?.scaleToSize(imageSize: size, backgroundColor: backgroundColor)
            }
            
            // 保存到内存中
            self.imageCacheDictioary[key] = newImage!
            
            // 完成回调
            completion(newImage)
        }
    }
    
    /// 清除缓存
    @objc private func removeCache() -> Void
    {
        imageCacheDictioary.removeAll();
    }
    
    /// 裁剪图片
    ///
    /// - Parameters:
    ///   - sourceImage: 原始图片
    ///   - imageSize: 目标尺寸
    ///   - backgroundColor: 背景颜色
    /// - Returns: UIImage
    private func clipImage(sourceImage:UIImage, imageSize:CGSize,backgroundColor:UIColor = UIColor.white) -> UIImage?
    {
        // 1.开启图片上下文
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0) // 不透明的上下文
        let rect = CGRect(origin: CGPoint.zero, size: imageSize)
        
        // 2.绘制背景颜色
        backgroundColor.setFill()
        UIBezierPath(rect: rect).fill()
        
        // 4.绘制图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.width / sourceImage.size.width * sourceImage.size.height))
        
        // 5.取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        // 7.返回图片
        return newImage
    }
}
