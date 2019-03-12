//
//  XGTopicListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicListViewModel: NSObject
{
    /// 数据模型数组
    private(set) public var topicList = [XGTopicViewModel]()
}

// MARK: - 网络请求数据

extension XGTopicListViewModel
{
    /// 获取自定义类型的帖子
    ///
    /// - Parameters:
    ///   - type: 帖子类型
    ///   - completion: 完成类型
    open func loadTopicList(type:XGTopicType,completion:@escaping (Bool)-> Void) -> Void
    {
        XGDataManager.loadTopicList(type: type) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArr = responseObject?["list"] as? [[String:Any]]
            let topicModelArr = XGTopicModel.mj_objectArray(withKeyValuesArray: dictArr!) as? [XGTopicModel]
            // 模型转视图模型
            for topicModel in topicModelArr ?? [] {
                self.topicList.append(XGTopicViewModel(model: topicModel))
            }
            
            // 完成回调
            completion(true)
        }
    }
}
