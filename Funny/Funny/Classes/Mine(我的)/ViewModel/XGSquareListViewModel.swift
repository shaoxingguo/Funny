//
//  XGSquareListViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGSquareListViewModel
{
    /// 数据模型数组
    private(set) open var squareList = [XGSquareModel]()
}

// MARK: - 网络请求数据

extension XGSquareListViewModel
{
    
    /// 获取“我”板块功能列表
    ///
    /// - Parameter completion: 完成回调
    open func loadSquareList(completion:@escaping (Bool) -> Void) -> Void
    {
        XGDataManager.loadSquareList { (responseObject, error) in
            if responseObject == nil || error != nil {
                completion(false)
                return
            }
            
            var dictArray = responseObject?["square_list"] as? [Any]
            // 删除最后一个空白数据
            dictArray?.removeLast()
            // 字典转模型
            let squareModelList = XGSquareModel.mj_objectArray(withKeyValuesArray: dictArray!) as? [XGSquareModel]
            self.squareList += (squareModelList ?? [])
            // 完成回调
            completion(true)
        }
    }
}
