//
//  XGLoginView.swift
//  Funny
//
//  Created by monkey on 2019/3/14.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGLoginView: UIView
{
    // MARK: - 私有属性
    
}


// MARK: - 其他方法

extension XGLoginView
{
    /// xib创建对象方法
    open class func loginView() -> XGLoginView
    {
        return Bundle.main.loadNibNamed("XGLoginView", owner: nil, options: nil)?.last as! XGLoginView
    }
}
