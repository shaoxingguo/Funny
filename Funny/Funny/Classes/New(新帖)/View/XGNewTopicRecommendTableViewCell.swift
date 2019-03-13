//
//  XGNewTopicRecommendTableViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGNewTopicRecommendTableViewCell: UITableViewCell
{
     // MARK: - 数据模型
    
    open var newTopicRecommendModel:XGNewTopicRecommendModel? {
        didSet {
            XGImageCacheManager.shared.imageForKey(key: newTopicRecommendModel?.imageList, size: CGSize(width: kTopicCellUserIconWidth, height: kTopicCellUserIconWidth), backgroundColor: backgroundColor ?? UIColor.white, isUserIcon: true) { (image) in
                self.userIconImageView.image = image
            }
            userNameLabel.text = newTopicRecommendModel?.themeName
            fansCountLabel.text = newTopicRecommendModel?.subNumber.toThousandString().appending("人关注")
        }
    }
    
    // MARK: - 私有属性
    
    /// 用户头像
    @IBOutlet private weak var userIconImageView: UIImageView!
    /// 用户名称
    @IBOutlet private weak var userNameLabel: UILabel!
    /// 关注人数
    @IBOutlet private weak var fansCountLabel: UILabel!
}
