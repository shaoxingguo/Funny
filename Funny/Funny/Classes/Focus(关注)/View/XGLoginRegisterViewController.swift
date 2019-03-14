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
    
    /// 关闭
    @IBAction func closeAction(_ button: UIButton)
    {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    /// 登录注册
    @IBAction func loginRegisterAction(_ button: UIButton)
    {
        button.isSelected = !button.isSelected
        let offset = button.isSelected ? scrollView.width : 0
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
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
        
        let registerView = XGRegisterView.registerView()
        scrollView.addSubview(registerView)
        registerView.frame = CGRect(x: scrollView.width, y: 0, width: scrollView.width, height: scrollView.height)
        
        scrollView.isScrollEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: 2 * scrollView.width, height: 0)
    }
}
