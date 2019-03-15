//
//  XGVidoTopicCellView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGVideoTopicCellView: UIView
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            playCountLabel.text = topicViewModel?.playCountStr
            playDurationLabel.text = topicViewModel?.videoTimeStr
            XGImageCacheManager.shared.imageForKey(key: topicViewModel?.imageURL, size: CGSize(width: kScreenWidth - 2 * kTopicCellMargin, height: topicViewModel?.imageHeight ?? 0), backgroundColor: backgroundColor ?? UIColor.white,isLongPicture:true) { (image) in
                self.backgroundImageView.image = image
            }
        }
    }
    
    // MARK: - 事件监听

    @IBAction private func playVideoAction(_ sender: UIButton)
    {
        XGPrint("播放视频")
    }
    
    // MARK: - 私有属性
    
    /// 播放时长
    @IBOutlet private weak var playDurationLabel: UILabel!
    /// 播放次数
    @IBOutlet private weak var playCountLabel: UILabel!
    /// 背景图片
    @IBOutlet private weak var backgroundImageView: UIImageView!
}

// MARK: - 其他方法

extension XGVideoTopicCellView
{
    /// xib创建对象方法
    open class func videoTopicCellView() -> XGVideoTopicCellView
    {
        return Bundle.main.loadNibNamed("XGVideoTopicCellView", owner: nil, options: nil)?.last as! XGVideoTopicCellView
    }
}
