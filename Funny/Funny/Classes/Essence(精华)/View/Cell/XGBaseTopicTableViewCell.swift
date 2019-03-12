//
//  XGBaseTopicTableViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGBaseTopicTableViewCell: UITableViewCell
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            topView.topicViewModel = topicViewModel
            contentLabel.text = topicViewModel?.text
            bottomView.topicViewModel = topicViewModel
            if topicViewModel?.isHasHotComment == true {
                hotCommentView.hotCommentModel = topicViewModel?.hotCommentModel
                hotCommentView.isHidden = false
            } else {
                hotCommentView.isHidden = true
            }
        }
    }
    
    // MARK: - 构造方法
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置界面
    open func setUpUI() -> Void
    {
        backgroundColor = UIColor.white
        
        // 添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        addSubview(hotCommentView)
        contentView.addSubview(bottomView)
        
        // 设置自动布局
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(kTopicCellTopViewHeight)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(kTopicCellMargin)
            make.left.equalTo(contentView).offset(kTopicCellMargin)
            make.right.equalTo(contentView).offset(-kTopicCellMargin)
            make.height.lessThanOrEqualTo(200)
        }
        
        hotCommentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(bottomView.snp.top).offset(-kTopicCellMargin)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(kTopicCellBottomViewHeight)
        }
    }
    
    // MARK: - 懒加载
    
    /// 顶部视图
    private lazy var topView = XGTopicCellTopView.topicCellTopView()
    /// 正文
    private lazy var contentLabel = UILabel(text: "正文", fontSize: kContentTextFontSize, textColor: UIColor.darkGray, textAlignment: .left)
    /// 热评视图
    private lazy var hotCommentView = XGHotCommentView.hotCommentView()
    /// 底部视图
    private lazy var bottomView = XGTopicCellBottomView.topicCellBottomView()
}
