//
//  XGTopicTableViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicTableViewCell: UITableViewCell
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            topView.topicViewModel = topicViewModel
            bottomView.topicViewModel = topicViewModel
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
    
    /// 顶部视图
    private lazy var topView = XGTopicCellTopView.topicCellTopView()
    /// 底部视图
    private lazy var bottomView = XGTopicCellBottomView.topicCellBottomView()
}

// MARK: - 设置界面

private extension XGTopicTableViewCell
{
    func setUpUI() -> Void
    {
        backgroundColor = UIColor.white

        // 添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        
        // 设置自动布局
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(kTopicCellTopViewHeight)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(kTopicCellBottomViewHeight)
        }
    }
}
