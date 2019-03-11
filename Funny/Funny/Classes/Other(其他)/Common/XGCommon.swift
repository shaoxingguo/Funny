//
//  XGCommon.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

// MARK: - 调试相关

func XGPrint(_ item : Any, file : String = #file, lineNum : Int = #line)
{
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("fileName:\(fileName)" + "\t" + "lineNum:\(lineNum)" + "\t" + "\(item)")
    #endif
}

// MARK: - 应用程序相关

/// 屏幕宽度
public let kScreenWidth:CGFloat = UIScreen.main.bounds.width
/// 屏幕高度
public let kScreenHeight:CGFloat = UIScreen.main.bounds.height
public let kScreenScale:CGFloat = UIScreen.main.scale
/// 导航栏高度
public let kNavigationBarHeight:CGFloat = 64
/// tabBar高度
public let kTabBarHeight:CGFloat = 49
/// 工具栏高度
public let kToolBarHeight:CGFloat = 44
