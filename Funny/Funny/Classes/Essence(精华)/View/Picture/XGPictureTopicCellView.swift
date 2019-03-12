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
            gifImageView.isHidden = (topicViewModel?.isGIF == true)
            XGImageCacheManager.shared.imageForKey(key: topicViewModel?.imageURL, size: backgroudImageView.size, backgroundColor: backgroundColor ?? UIColor.white) { (image) in
                self.backgroudImageView.image = image
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
    
    /// 背景图片
    @IBOutlet private weak var backgroudImageView: UIImageView!
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
