//
//  XGSquareCollectionViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/14.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGSquareCollectionViewCell: UICollectionViewCell
{
    // MARK: - 解析模型
    
    open var squareModel:XGSquareModel? {
        didSet {
            titleLabel.text = squareModel?.name
            XGImageCacheManager.shared.imageForKey(key: squareModel?.icon, size: iconImageView.size, backgroundColor: backgroundColor ?? UIColor.white, isUserIcon: true) { (image) in
                self.iconImageView.image = image
            }
        }
    }

    // MARK: - 私有属性
    
    /// 图标
    @IBOutlet private weak var iconImageView: UIImageView!
    /// 标题
    @IBOutlet private weak var titleLabel: UILabel!
}
