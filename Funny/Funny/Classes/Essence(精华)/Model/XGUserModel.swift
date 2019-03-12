//
//  XGUserModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

@objcMembers class XGUserModel: NSObject
{
    /// 昵称
    var userName:String?
    /// 头像
    var profileImage:String?
}

// MARK: - MJExtension

extension XGUserModel
{
    override class func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
        if propertyName == "userName" {
            return "username"
        } else {
            return (propertyName as NSString).mj_underlineFromCamel()
        }
    }
}
