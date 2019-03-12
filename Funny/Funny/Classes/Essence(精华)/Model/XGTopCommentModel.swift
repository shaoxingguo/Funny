//
//  XGTopCommentModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

@objcMembers class XGTopCommentModel: NSObject
{
    /// 热评内容
    var content:String?
    /// 点赞数
    var likeCount:Int = 0
    /// 语音热评url
    var voiceUrl:String?
    /// 用户
    var user:XGUserModel?
}

extension XGTopCommentModel
{
    override class func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
        if propertyName == "voiceUrl" {
            return "voiceuri"
        } else {
            return (propertyName as NSString).mj_underlineFromCamel()
        }
    }
}
