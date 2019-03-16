//
//  XGRecommendItemTableViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/16.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRecommendItemTableViewCell: UITableViewCell
{
    // MARK: - 构造方法
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载

    /// 头像
    private lazy var iconImageView:UIImageView = UIImageView()
    /// 标题
    private lazy var screenNameLabel:UILabel = UILabel(text: "标题", fontSize: 15, textColor: UIColor.darkGray, textAlignment: .center)
    /// 关注人数
    private lazy var fansCountLabel:UILabel = UILabel(text: "粉丝", fontSize: 15, textColor: UIColor.darkGray, textAlignment: .center)
}

// MARK: - 设置界面

private extension XGRecommendItemTableViewCell
{
    func setUpUI() -> Void
    {
        
    }
}
