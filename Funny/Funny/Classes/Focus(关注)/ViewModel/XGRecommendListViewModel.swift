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
    ///   - category: 分类
    ///   - completion: 完成回调
    open func loadRecommendItemList(recommendCategoryModel:XGRecommendCategoryModel,completion:@escaping (Bool) -> Void) -> Void
    {
        // 判断页码 是否还有数据
        let page = recommendCategoryModel.page == 0 ? 1 : recommendCategoryModel.page
        if page == recommendCategoryModel.totalPage {
            XGPrint("推荐标签已经全部加载完毕,没有更多数据")
            completion(false)
            return
        }
        
        XGDataManager.loadRecommendItemList(categoryId: recommendCategoryModel.id, page: page) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArray = responseObject?["list"] as? [[String:Any]]
            let itemModelList = XGRecommendItemModel.mj_objectArray(withKeyValuesArray: dictArray!) as? [XGRecommendItemModel]
            // 标签总数
            recommendCategoryModel.count = (responseObject?["count"] as? Int) ?? 0
            // 总页码
            recommendCategoryModel.totalPage = (responseObject?["total_page"] as? Int) ?? 0
            // 当前页码
            recommendCategoryModel.page += 1
            // 标签数组
            recommendCategoryModel.items += (itemModelList ?? [])
            // 完成回调
            completion(true)
        }
    }
}

