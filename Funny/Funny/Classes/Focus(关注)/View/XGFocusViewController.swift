//
//  XGFocusViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGFocusViewController: UIViewController
{
    // MARK: - 事件监听
    
    @IBAction func loginAction(_ sender: UIButton)
    {
        let loginRegisterViewController = XGLoginRegisterViewController()
        present(loginRegisterViewController, animated: true, completion: nil)
    }
}
