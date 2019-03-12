//
//  XGTopicViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicViewModel: NSObject
{
    /// 用户的名字
    open var name:String? {
        return topicModel?.name
    }
    
    /// 用户的头像
    open var profileImage:String? {
        return topicModel?.profileImage
    }
    
    /// 帖子的文字内容
    open var text:String? {
        return topicModel?.text
    }
    
    /// 帖子审核通过的时间
    open var passtime:String? {
        return topicModel?.passtime
    }
    
    /// 是否有热评
    open var isHasHotComment:Bool {
        return topicModel?.topCmt != nil
    }
    
    /// 热评数据模型
    open var hotCommentModel:XGHotCommentModel? {
        return topicModel?.topCmt
    }
    
    /// 是否是GIF
    open var isGIF:Bool {
        return topicModel?.isGif == true
    }
    
    /// 图片URL地址
    open var imageURL:String? {
        return topicModel?.imageURL
    }
    
    /// 赞
    private(set) open var likeStr:String?
    /// 踩
    private(set) open var unlikeStr:String?
    /// 分享
    private(set) open var shareStr:String?
    /// 评论
    private(set) open var commentStr:String?
    
    /// 行高
    private(set) open var rowHeight:CGFloat = 0
    
    /// 帖子类型
    private(set) open var type:XGTopicType
    
    /// 图片高度
    private(set) open var imageHeight:CGFloat = 0
    
    // MARK: - 构造方法
    
    /// 帖子模型
    private var topicModel:XGTopicModel?
    
    init(model:XGTopicModel)
    {
        topicModel = model
        type = XGTopicType(rawValue: model.type)!

        super.init()
     
        // 设置属性值
        likeStr = numberToString(number: topicModel?.ding ?? 0)
        unlikeStr = numberToString(number: topicModel?.cai ?? 0)
        shareStr = numberToString(number: topicModel?.repost ?? 0)
        commentStr = numberToString(number: topicModel?.comment ?? 0)
        
        imageHeight = (kScreenWidth - 2 * kTopicCellMargin) / model.width * model.height
        imageHeight = imageHeight > 200 ? 200 : imageHeight
        
        rowHeight = calcRowHeight()
    }
}

// MARK: - 其他方法

private extension XGTopicViewModel
{
    
    /// 数字转换成字符串
    ///
    /// - Parameter number: 数字
    /// - Returns: 字符串
    func numberToString(number:Int) -> String?
    {
        
        var str:String
        if number < 10000 {
            str = "\(number)" // 小于1万
        } else {
            // 大于1万
            str = String(format: "%.2f", CGFloat(number) / CGFloat(10000))
            // 处理 2.00
            if str.hasSuffix(".00") {
                let location = (str as NSString).range(of: ".00").location
                str = (str as NSString).substring(to: location)
            } else if str.hasSuffix("0") {
                // 处理 2.20
                let index = str.index(str.endIndex, offsetBy: -1)
                str = String(str[..<index])
            }
            
            str += "万"
        }
        
        return str
    }
    
    /// 计算行高
    func calcRowHeight() -> CGFloat
    {
        var height:CGFloat = 0
        
        // 顶部视图高度
        height += kTopicCellTopViewHeight;
        
        if let text = text {
            // 正文高度
             height += (kTopicCellMargin + ((text as NSString).boundingRect(with: CGSize(width: kScreenWidth - 2 * kTopicCellMargin, height: 200), options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: kContentTextFontSize)], context: nil).size.height))
        }
        
        if let _ = topicModel?.imageURL {
            // 图片高度
            height += (kTopicCellMargin + imageHeight)
        }
       
        if let _ = hotCommentModel {
            // 热评高度
            height += (kTopicCellMargin + kTopicCellHotCommentViewHeight)
        }
        
        // 底部视图
        height += (kTopicCellMargin + kTopicCellBottomViewHeight)
        
        return ceil(height)
    }
}
