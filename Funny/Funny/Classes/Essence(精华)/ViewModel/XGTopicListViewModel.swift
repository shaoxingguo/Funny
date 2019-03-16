//
//  XGTopicListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicListViewModel
{
    /// 数据模型数组
    private(set) open var topicList = [XGTopicViewModel]()
}

// MARK: - 网络请求数据

extension XGTopicListViewModel
{
    /// 获取自定义类型的帖子
    ///
    /// - Parameters:
    ///   - type: 帖子类型
    ///   - isNewTopocList: 是否是新帖 默认false
    ///   - maxId: 帖子id 加载比此id小的帖子 加载更多数据
    ///   - minId: 帖子id 加载比此id大的帖子 加载最新数据
    ///   - completion: 完成回调
    open func loadTopicList(type:XGTopicType,isNewTopicList:Bool = false, maxId:Int = 0, minId:Int = 0, completion:@escaping (Bool)-> Void) -> Void
    {
        XGDataManager.loadTopicList(type: type, isNewTopicList: isNewTopicList, maxId: maxId, minId: minId) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            // 字典转模型
            let dictArr = responseObject?["list"] as? [[String:Any]]
            let topicModelArr = XGTopicModel.mj_objectArray(withKeyValuesArray: dictArr!) as? [XGTopicModel]
            if minId != 0 {
                // 下拉刷新 加载最新帖子 删除之前的帖子 加载最新数据
                self.topicList.removeAll()
            }
            
            // 模型转视图模型
            for topicModel in topicModelArr ?? [] {
                self.topicList.append(XGTopicViewModel(model: topicModel))
            }
            
            // 完成回调
            completion(true)
        }
    }
}
