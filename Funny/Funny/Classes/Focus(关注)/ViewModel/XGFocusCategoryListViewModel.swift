//
//  XGFocusCategoryListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGFocusCategoryListViewModel
{
    /// 数据模型数组
    private(set) open var categoryList = [XGFocusCategoryModel]()
}

// MARK: - 网络请求数据

extension XGFocusCategoryListViewModel
{
    
    /// 获取“推荐关注”中左侧标签的列表
    ///
    /// - Parameter completion: 完成回调
    open func loadFocusCategoryList(completion:@escaping (Bool) -> Void) -> Void
    {
        XGDataManager.loadFocusCategoryList { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArray = responseObject?["list"] as? [[String:Any]]
            let categoryModelList = XGFocusCategoryModel.mj_objectArray(withKeyValuesArray: dictArray!) as? [XGFocusCategoryModel]
            self.categoryList += (categoryModelList ?? [])
        }
    }
}

