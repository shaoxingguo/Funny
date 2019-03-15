//
//  XGRecommendFocusTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRecommendFocusTableViewController: UITableViewController
{

    /// 分类列表视图模型
    private lazy var focusCategoryListViewModel = XGFocusCategoryListViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "推荐关注"
        loadCategoryData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


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
}
