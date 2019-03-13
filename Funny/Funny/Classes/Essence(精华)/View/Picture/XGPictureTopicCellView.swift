//
//  XGPictureTopicCellView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGPictureTopicCellView: UIView
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            seeBigPictureButton.isHidden = (topicViewModel?.isLongPicture == false)
            gifImageView.isHidden = (topicViewModel?.isGIF != true)
            XGImageCacheManager.shared.imageForKey(key: topicViewModel?.imageURL, size: CGSize(width: kScreenWidth - 2 * kTopicCellMargin, height: topicViewModel?.imageHeight ?? 0), backgroundColor: backgroundColor ?? UIColor.white,isLongPicture:true) { (image) in
                self.backgroundImageView.image = image
            }
        }
    }
    
    // MARK: - 事件监听
    
    /// 查看大图事件
    @IBAction func seeBigPictureAction(_ sender: UIButton)
    {
        // TODO:查看大图
        XGPrint("查看大图")
    }
    
    // MARK: - 私有属性
    
    /// 查看大图按钮
    @IBOutlet weak var seeBigPictureButton: UIButton!
    /// 背景图片
    @IBOutlet private weak var backgroundImageView: UIImageView!
    /// gif标记
    @IBOutlet private weak var gifImageView: UIImageView!
}

// MARK: - 其他方法

extension XGPictureTopicCellView
{
    /// xib创建对象方法
    open class func pictureTopicCellView() -> XGPictureTopicCellView
    {
        return Bundle.main.loadNibNamed("XGPictureTopicCellView", owner: nil, options: nil)?.last as! XGPictureTopicCellView
    }
}
