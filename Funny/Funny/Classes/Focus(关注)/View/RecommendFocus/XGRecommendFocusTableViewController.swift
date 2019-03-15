//
//  XGRecommendFocusTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRecommendFocusTableViewController: UIViewController
{

    /// 分类列表视图模型
    private lazy var focusCategoryListViewModel = XGFocusCategoryListViewModel()
    
    // MARK: - 控制器生命周期方法
    
    override func loadView()
    {
        super.loadView()
        
        setUpUI()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "推荐关注"
//        loadCategoryData()
    }
    
    // MARK: - 懒加载
    
    /// 分类列表
    private lazy var categoryListTableView = UITableView()
    /// 推荐标签列表
    private lazy var recommendTagListTableView = UITableView()
}

// MARK: - 其他方法

private extension XGRecommendFocusTableViewController
{
    /// 加载分类数据
    func loadCategoryData() -> Void
    {
        focusCategoryListViewModel.loadFocusCategoryList { (isSuccess) in
            if !isSuccess {
                XGPrint("加载推荐分类数据失败")
                return
            }
            
            // 刷新表格
        }
    }
    
    func setUpUI() -> Void
    {
        view.backgroundColor = UIColor.white
        categoryListTableView.backgroundColor = UIColor.purple
        recommendTagListTableView.backgroundColor = UIColor.orange
        // 添加子控件
        view.addSubview(categoryListTableView)
        view.addSubview(recommendTagListTableView)
        
        // 设置自动布局
        categoryListTableView.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(view)
            make.width.equalTo(80)
            make.height.equalTo(100).priority(.high)
        }
        
        recommendTagListTableView.snp.makeConstraints { (make) in
            make.left.equalTo(categoryListTableView.snp.right).offset(15)
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view.snp_bottomMargin)
        }
    }
}

