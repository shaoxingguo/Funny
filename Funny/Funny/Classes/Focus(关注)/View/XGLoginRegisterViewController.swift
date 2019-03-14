//
//  XGLoginRegisterViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/14.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGLoginRegisterViewController: UIViewController
{
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpScrollView()
    }

    // MARK: - 事件监听
    
    @IBAction func closeAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 私有属性
    
    /// scrollView
    @IBOutlet private weak var scrollView: UIScrollView!
}

// MARK: - 其他方法

extension XGLoginRegisterViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 设置scrollView
    private func setUpScrollView() -> Void
    {
        view.layoutIfNeeded()
        
        let loginView = XGLoginView.loginView()
        
        scrollView.addSubview(loginView)
        loginView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
    }
}
