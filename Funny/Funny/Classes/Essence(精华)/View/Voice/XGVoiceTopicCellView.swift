//
//  XGVoiceTopicCellView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGVoiceTopicCellView: UIView
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            playCountLabel.text = topicViewModel?.playCountStr
            playDurationLabel.text = topicViewModel?.voiceTimeStr
            XGImageCacheManager.shared.imageForKey(key: topicViewModel?.imageURL, size: CGSize(width: kScreenWidth - 2 * kTopicCellMargin, height: topicViewModel?.imageHeight ?? 0), backgroundColor: backgroundColor ?? UIColor.white,isLongPicture:true) { (image) in
                self.backgroundImageView.image = image
            }
        }
    }
    
    // MARK: - 私有属性
    
    /// 背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    /// 播放次数
    @IBOutlet weak var playCountLabel: UILabel!
    /// 播放时长
    @IBOutlet weak var playDurationLabel: UILabel!
    
    // MARK: - 事件监听
    
    @IBAction func playVoiceAction(_ sender: UIButton)
    {
        
    }
}

// MARK: - 其他方法

extension XGVoiceTopicCellView
{
    /// xib创建对象方法
    open class func voiceTopicCellView() -> XGVoiceTopicCellView
    {
        return Bundle.main.loadNibNamed("XGVoiceTopicCellView", owner: nil, options: nil)?.last as! XGVoiceTopicCellView
    }
}
