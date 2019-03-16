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
    // MARK: - 数据模型
    
    open var recommendItemModel:XGRecommendItemModel? {
        didSet {
            screenNameLabel.text = recommendItemModel?.screenName
            fansCountLabel.text = recommendItemModel?.fansCount.toThousandString().appending("人关注")
            XGImageCacheManager.shared.imageForKey(key: recommendItemModel?.header, size: CGSize(width: 50, height: 50), backgroundColor: contentView.backgroundColor ?? UIColor.white, isUserIcon: true) { (image) in
                self.iconImageView.image = image
            }
        }
    }
    
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
    /// 名称
    private lazy var screenNameLabel:UILabel = UILabel(text: "标题", fontSize: kContentTextFontSize, textColor: UIColor.black, textAlignment: .center)
    /// 关注人数
    private lazy var fansCountLabel:UILabel = UILabel(text: "粉丝", fontSize: kSummarizeTextFontSize, textColor: UIColor.darkGray, textAlignment: .center)
}

// MARK: - 设置界面

private extension XGRecommendItemTableViewCell
{
    func setUpUI() -> Void
    {
        contentView.backgroundColor = UIColor.white
        
        // 添加子控件
        contentView.addSubview(iconImageView)
        contentView.addSubview(screenNameLabel)
        contentView.addSubview(fansCountLabel)
        
        // 设置自动布局
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kTopicCellMargin)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        screenNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(kTopicCellMargin)
        }
        
        fansCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(kTopicCellMargin)
            make.bottom.equalTo(iconImageView)
        }
    }
}
