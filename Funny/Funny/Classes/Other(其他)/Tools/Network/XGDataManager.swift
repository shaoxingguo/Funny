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
    ///   - competion: 完成回调
    open class func loadTopicList(type:XGTopicType,competion:@escaping ([String:Any]?,Error?) -> Void) -> Void
    {
        let parameters:[String:Any] = ["a" : "list",
                          "c" : "data",
                          "type" : type.rawValue]
        XGNetworkManager.request(type: .Get, URLString: kTopicListAPI, parameters: parameters) { (responseObject, error) in
            if responseObject == nil || error != nil {
                competion(nil,error)
                return
            }
            
            competion(responseObject as? [String:Any],nil)
        }
    }
}
