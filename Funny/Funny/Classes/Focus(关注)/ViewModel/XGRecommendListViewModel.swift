//
//  XGFocusCategoryListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRecommendListViewModel
{
    /// 分类数据模型数组
    private(set) open var categoryList = [XGRecommendCategoryModel]()
    /// 标签数据模型数组
    private(set) open var itemList = [XGRecommendItemModel]()
}

// MARK: - 网络请求数据

extension XGRecommendListViewModel
{
    
    /// 获取“推荐关注”中左侧标签的列表
    ///
    /// - Parameter completion: 完成回调
    open func loadRecommendCategoryList(completion:@escaping (Bool) -> Void) -> Void
    {
        XGDataManager.loadRecommendCategoryList { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArray = responseObject?["list"] as? [[String:Any]]
            let categoryModelList = XGRecommendCategoryModel.mj_objectArray(withKeyValuesArray: dictArray!) as? [XGRecommendCategoryModel]
            self.categoryList += (categoryModelList ?? [])
            completion(true)
        }
    }
    
    
    /// 获取“推荐关注”中左侧标签每个标签对应的推荐用户组
    ///
    /// - Parameters:
    ///   - categoryId: 分类ID
    ///   - completion: 完成回调
    open func loadRecommendItemList(categoryId:Int,completion:@escaping (Bool) -> Void) -> Void
    {
        XGDataManager.loadRecommendItemList(categoryId: categoryId) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArray = responseObject?["list"] as? [[String:Any]]
            let itemModelList = XGRecommendItemModel.mj_objectArray(withKeyValuesArray: dictArray!) as? [XGRecommendItemModel]
            self.itemList += (itemModelList ?? [])
            completion(true)
        }
    }
}

