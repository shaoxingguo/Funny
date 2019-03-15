//
//  XGRegisterView.swift
//  Funny
//
//  Created by monkey on 2019/3/14.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGRegisterView: UIView
{
}

// MARK: - 其他方法

extension XGRegisterView
{
    /// xib创建对象方法
    open class func registerView() -> XGRegisterView
    {
        return Bundle.main.loadNibNamed("XGRegisterView", owner: nil, options: nil)?.last as! XGRegisterView
    }
}
