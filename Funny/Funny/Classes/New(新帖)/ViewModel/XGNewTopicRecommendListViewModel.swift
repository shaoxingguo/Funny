//
//  XGNewTopicRecommendListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGNewTopicRecommendListViewModel
{
    /// 数据模型数组
    private(set) open var recommendList = [XGNewTopicRecommendModel]()
}

// MARK: - 网络请求数据

extension XGNewTopicRecommendListViewModel
{
    /// 获取标签订阅页面中推荐标签中的内容
    ///
    /// - Parameter completion: 完成回调
    open func loadNewTopicRecommendList(completion:@escaping(Bool) -> Void) -> Void
    {
        XGDataManager.loadNewTopicRecommendList { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let recommendListArray = XGNewTopicRecommendModel.mj_objectArray(withKeyValuesArray: responseObject!) as? [XGNewTopicRecommendModel]
            self.recommendList += (recommendListArray ?? [])
            // 完成回调
            completion(true)
        }
    }
}
