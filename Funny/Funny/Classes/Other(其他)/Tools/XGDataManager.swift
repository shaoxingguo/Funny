//
//  XGDataManager.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

public enum XGTopicType:Int
{
    case All = 1      // 全部
    case Picture = 10 // 图片
    case Word = 29   // 段子
    case Voice = 31  // 声音
    case Video = 41  // 视频
}

class XGDataManager: NSObject
{
    // MARK: - 单例
    
    /// 单例
    private static let shared:XGDataManager = XGDataManager()
    
    private override init()
    {
        
    }
}

// MARK: - 网络相关

extension XGDataManager
{
    /// 获取自定义类型的帖子
    ///
    /// - Parameters:
    ///   - type: 帖子类型
    ///   - completion: 完成回调
    
    /// 获取自定义类型的帖子
    ///
    /// - Parameters:
    ///   - type: 帖子类型
    ///   - isNewTopicList: 是否是新帖 默认false
    ///   - maxId: 帖子id 加载比此id小的帖子 加载更多数据
    ///   - minId: 帖子id 加载比此id大的帖子 加载最新数据
    ///   - completion: 完成回调
    open class func loadTopicList(type:XGTopicType,isNewTopicList:Bool = false, maxId:Int = 0, minId:Int = 0, completion:@escaping ([String:Any]?,Error?) -> Void) -> Void
    {
        var parameters:[String:Any] = ["c" : "data",
                          "type" : type.rawValue]
        // 判断是否是新帖
        if isNewTopicList {
            parameters["a"] = "newlist"
        } else {
            parameters["a"] = "list"
        }
        
        // 判断是否是上拉加载更多数据
        if maxId != 0 {
            parameters["maxtime"] = maxId
        }
        
        XGNetworkManager.request(type: .Get, URLString: kTopicListAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(nil,error)
                return
            }
            
            completion(responseObject as? [String:Any],nil)
        }
    }
    
    /// 获取标签订阅页面中推荐标签中的内容
    ///
    /// - Parameter completion: 完成回调
    open class func loadNewTopicRecommendList(completion:@escaping ([[String:Any]]?,Error?) -> Void) -> Void
    {
        let parameters:[String:Any] = ["a" : "tag_recommend",
                                       "c" : "topic",
                                       "action" : "sub"]
        XGNetworkManager.request(type: .Get, URLString: kNewTopicRecommendAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(nil,error)
                return
            }
            
            completion(responseObject as? [[String:Any]],nil)
        }
    }
    
    
    /// 获取“我”板块功能列表
    ///
    /// - Parameter completion: 完成回调
    open class func loadSquareList(completion:@escaping ([String:Any]?,Error?) -> Void) -> Void
    {
        let parameters:[String:Any] = ["a" : "square",
                                       "c" : "topic"]
        XGNetworkManager.request(type: .Get, URLString: kSquareListAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(nil,error)
                return
            }
            
            completion(responseObject as? [String:Any],nil)
        }
    }
    
    
    /// 获取“推荐关注”中左侧标签的列表
    ///
    /// - Parameter completion: 完成回调
    open class func loadRecommendCategoryList(completion:@escaping ([String:Any]?,Error?) -> Void) -> Void
    {
        let parameters:[String:Any] = ["a" : "category",
                                       "c" : "subscribe"]
        XGNetworkManager.request(type: .Get, URLString: kRecommendCategoryAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(nil,error)
                return
            }
            
            completion(responseObject as? [String:Any],nil)
        }
    }
    
    /// 获取“推荐关注”中左侧标签每个标签对应的推荐用户组
    ///
    /// - Parameters:
    ///   - categoryId: 分类ID
    ///   - page: 页码
    ///   - completion: 完成回调
    open class func loadRecommendItemList(categoryId:Int,page:Int = 1, completion:@escaping ([String:Any]?,Error?) -> Void) -> Void
    {
        let parameters:[String:Any] = ["a" : "list",
                                       "c" : "subscribe",
                                       "category_id": categoryId,
                                       "page": page]
        XGNetworkManager.request(type: .Get, URLString: kRecommendCategoryAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(nil,error)
                return
            }
            
            completion(responseObject as? [String:Any],nil)
        }
    }
}
