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
    // MARK: - 控制器生命周期方法

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpNavigationItem()
    }
    
    // MARK: - 事件监听
    
    @IBAction private func loginAction(_ sender: UIButton)
    {
        let loginRegisterViewController = XGLoginRegisterViewController()
        present(loginRegisterViewController, animated: true, completion: nil)
    }
    
    @objc private func pushToRecommendFocusTableViewController() -> Void
    {
        let viewController = XGRecommendFocusTableViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - 设置界面

private extension XGFocusViewController
{
    /// 设置导航栏
    func setUpNavigationItem() -> Void
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "tabBar_friendTrends_icon"), style: .plain, target: self, action: #selector(pushToRecommendFocusTableViewController))
    }
}
