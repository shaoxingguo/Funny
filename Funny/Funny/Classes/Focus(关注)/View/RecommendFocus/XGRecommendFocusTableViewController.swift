//
//  XGRecommendFocusTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

/// 分类cell重用标识符
private let kXGRecommendCategoryTableViewCellReuseIdentifer:String = "XGRecommendCategoryTableViewCell"
/// 推荐标签重用标识符
private let kXGRecommendItemTableViewCellReuseIdentifer:String = "XGRecommendItemTableViewCell"

class XGRecommendFocusTableViewController: UIViewController
{
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
        setUpTableView()
        loadRecmmendCategoryData()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    // MARK: - 懒加载 && 私有属性
    
    /// 分类列表视图模型
    private lazy var recommendListViewModel = XGRecommendListViewModel()
    /// 分类列表
    private lazy var recommendCategoryListTableView = UITableView()
    /// 推荐标签列表
    private lazy var recommendItemListTableView = UITableView()
    /// 当前选中的分类索引
    private var selectedCategoryIndex:Int = 0
}

// MARK: - UITableViewDataSource

extension XGRecommendFocusTableViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == recommendCategoryListTableView {
            // 左边分类tableView
            return recommendListViewModel.categoryList.count
        } else {
            // 右边推荐标签tableView
              recommendItemListTableView.mj_footer.isHidden = (recommendListViewModel.categoryList.count == 0 || recommendListViewModel.categoryList[selectedCategoryIndex].items.count == 0)
            return recommendListViewModel.categoryList.count > 0 ?recommendListViewModel.categoryList[selectedCategoryIndex].items.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == recommendCategoryListTableView {
            // 左边分类tableView
            let cell = tableView.dequeueReusableCell(withIdentifier: kXGRecommendCategoryTableViewCellReuseIdentifer) as! XGRecommendCategoryTableViewCell
            cell.recommendCategoryModel = recommendListViewModel.categoryList[indexPath.row]
            return cell
        } else {
            // 右边推荐标签tableView
            let cell = tableView.dequeueReusableCell(withIdentifier: kXGRecommendItemTableViewCellReuseIdentifer) as! XGRecommendItemTableViewCell
            cell.recommendItemModel = recommendListViewModel.categoryList[selectedCategoryIndex].items[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == recommendCategoryListTableView {
            // 左边分类tableView
            selectedCategoryIndex = indexPath.row
            let recommendCategoryModel = recommendListViewModel.categoryList[selectedCategoryIndex]
            if recommendCategoryModel.items.count > 0 {
                recommendItemListTableView.reloadData()
                checkFooterStatus()
            } else {
                recommendItemListTableView.reloadData()
                loadRecommendItemData()
            }
        } else {
            // 右边推荐标签tableView
           
        }
    }
}

// MARK: - 其他方法

private extension XGRecommendFocusTableViewController
{
    /// 加载推荐分类数据
    func loadRecmmendCategoryData() -> Void
    {
        SVProgressHUD.show()
        recommendListViewModel.loadRecommendCategoryList { (isSuccess) in
            SVProgressHUD.dismiss()
            if !isSuccess {
                XGPrint("加载推荐分类数据失败")
                return
            }

            // 刷新表格
            self.recommendCategoryListTableView.reloadData()
            // 选中第一个分类
            self.recommendCategoryListTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            // 加载分类下数据
            self.loadRecommendItemData()
        }
    }
    
    /// 加载推荐标签数据
    @objc func loadRecommendItemData() -> Void
    {
        recommendListViewModel.loadRecommendItemList(recommendCategoryModel: recommendListViewModel.categoryList[selectedCategoryIndex]) { (isSuccess) in
            if !isSuccess {
                XGPrint("加载推荐标签数据失败")
                return
            }
            
            // 刷新表格
            self.recommendItemListTableView.reloadData()
            self.checkFooterStatus()
        }
    }
    
    /// 检查上拉刷新控件状态
    func checkFooterStatus() -> Void
    {
        // 当推荐分类或推荐标签没有数据时 隐藏上拉刷新控件
        recommendItemListTableView.mj_footer.isHidden = (recommendListViewModel.categoryList.count == 0 || recommendListViewModel.categoryList[selectedCategoryIndex].items.count == 0)
        let recommendCategoryModel = recommendListViewModel.categoryList[selectedCategoryIndex]
        if recommendCategoryModel.items.count < recommendCategoryModel.count {
            recommendItemListTableView.mj_footer.endRefreshing()
        } else {
            recommendItemListTableView.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    func setUpUI() -> Void
    {
        view.backgroundColor = UIColor.purple
        recommendCategoryListTableView.backgroundColor = UIColor.purple
        recommendItemListTableView.backgroundColor = UIColor.purple
        
        // 添加子控件
        view.addSubview(recommendCategoryListTableView)
        view.addSubview(recommendItemListTableView)
        
        // 设置自动布局
        recommendCategoryListTableView.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(view)
            make.width.equalTo(80)
            make.height.equalTo(5 * 44).priority(.high)
        }
        
        recommendItemListTableView.snp.makeConstraints { (make) in
            make.left.equalTo(recommendCategoryListTableView.snp.right).offset(15)
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view.snp_bottomMargin)
        }
    }
    
    /// 设置tableView
    func setUpTableView() -> Void
    {
        // 设置数据源和代理
        recommendCategoryListTableView.dataSource = self
        recommendCategoryListTableView.delegate = self
        recommendItemListTableView.dataSource = self
        recommendItemListTableView.delegate = self
        
        // 注册cell
        recommendCategoryListTableView.register(XGRecommendCategoryTableViewCell.self, forCellReuseIdentifier: kXGRecommendCategoryTableViewCellReuseIdentifer)
        recommendItemListTableView.register(XGRecommendItemTableViewCell.self, forCellReuseIdentifier: kXGRecommendItemTableViewCellReuseIdentifer)
        
        // 设置行高
        recommendCategoryListTableView.rowHeight = 44
        recommendItemListTableView.rowHeight = 60
        
        // 设置上拉刷新
        recommendItemListTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadRecommendItemData))
        recommendItemListTableView.mj_footer.backgroundColor = UIColor.white
    }
}
