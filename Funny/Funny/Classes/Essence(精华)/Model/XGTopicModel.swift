//
//  XGTopicModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import MJExtension

@objcMembers class XGTopicModel: NSObject
{
    /// 用户的名字
    var name:String?
    /// 用户的头像
    var profileImage:String?
    /// 帖子的文字内容
    var text:String?
    /// 帖子审核通过的时间
    var passtime:String?
    
    /// 顶数量
    var ding:Int = 0
    /// 踩数量
    var cai:Int = 0
    /// 转发分享数量
    var repost:Int = 0
    /// 评论数量
    var comment:Int = 0
    
    /// 帖子时间id
    var timeId:Int = 0
    /// 热评
    var topCmt:XGHotCommentModel?
    /// 图片高度
    var height:CGFloat = 0
    /// 图片宽度
    var width:CGFloat = 0
    /// 背景图片
    var imageURL:String?
    /// 帖子类型
    var type:Int = 0
    /// 是否是gif
    var isGif:Bool = false
    /// 播放次数
    var playcount:Int = 0
    /// 视频时长
    var videotime:Int = 0
    /// 声音时长
    var voicetime:Int = 0
}

/*
 [self mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
 if ([propertyName isEqualToString:@"timeId"]) {
 return @"t";
 } else if ([propertyName isEqualToString:@"topCmt"]) {
 return @"top_cmt[0]";
 } else if ([propertyName isEqualToString:@"imageURL"]) {
 return @"image0";
 }
 else {
 return [propertyName mj_underlineFromCamel];
 }
 }];
 */

// MARK: - MJExtension

extension XGTopicModel
{
    override class func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
        if propertyName == "timeId" {
            return "t"
        } else if propertyName == "topCmt" {
            return  "top_cmt[0]"
        } else if propertyName == "imageURL" {
            return "image0"
        } else {
            return (propertyName as NSString).mj_underlineFromCamel()
        }
    }
}


