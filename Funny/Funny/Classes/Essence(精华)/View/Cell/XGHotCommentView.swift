//
//  XGHotCommentView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGHotCommentView: UIView
{
   // MARK: - 数据模型
    
    open var hotCommentModel:XGHotCommentModel? {
        didSet {
            XGImageCacheManager.shared.imageForKey(key: hotCommentModel?.user?.profileImage, size: CGSize(width: 30, height: 30), backgroundColor: backgroundColor ?? UIColor.white, isUserIcon: true) { (image) in
                self.userIconImageView.image = image
            }
            
            userNameLabel.text = hotCommentModel?.user?.userName
            contentTextLabel.text = (hotCommentModel?.voiceUrl != "" && hotCommentModel?.voiceUrl != nil) ? "[语音]" : hotCommentModel?.content
        }
    }
    
    // MARK: - 私有属性
    
    /// 用户头像
    @IBOutlet private weak var userIconImageView: UIImageView!
    /// 用户名称
    @IBOutlet private weak var userNameLabel: UILabel!
    /// 内容
    @IBOutlet private weak var contentTextLabel: UILabel!
}

// MARK: - 其他方法

extension XGHotCommentView
{
    /// xib创建对象方法
    open class func hotCommentView() -> XGHotCommentView
    {
        return Bundle.main.loadNibNamed("XGHotCommentView", owner: nil, options: nil)?.last as! XGHotCommentView
    }
}
