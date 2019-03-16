//
//  XGFocusCategoryTableViewCell.swift
//  Funny
//
//  Created by monkey on 2019/3/16.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRecommendCategoryTableViewCell: UITableViewCell
{
    // MARK: - 数据模型
    
    open var focusCategoryModel:XGRecommendCategoryModel? {
        didSet {
            titleLabel.text = focusCategoryModel?.name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        separateView.isHidden = !selected
        titleLabel.textColor = selected ? UIColor.red : UIColor.darkGray
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
    
    /// 标题
    private lazy var titleLabel:UILabel = UILabel(text: "标题", fontSize: 15, textColor: UIColor.darkGray, textAlignment: .center)
    /// 分割视图
    private lazy var separateView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
}

// MARK: - 设置界面

private extension XGRecommendCategoryTableViewCell
{
    func setUpUI() -> Void
    {
        backgroundColor = UIColor.white
        selectionStyle = .none
        
        // 添加子控件
        contentView.addSubview(titleLabel)
        contentView.addSubview(separateView)
        
        // 设置自动布局
        separateView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(contentView)
            make.width.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
}
