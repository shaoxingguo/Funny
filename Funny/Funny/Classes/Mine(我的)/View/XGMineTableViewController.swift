//
//  XGMineTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SafariServices
import SVProgressHUD

/// XGSquareCollectionViewCell重用标识符
private let kSquareCollectionViewCellReuseIdentifier = "XGSquareCollectionViewCell"
/// 功能模块分几列
private let kColumns:Int = 4

class XGMineTableViewController: UITableViewController
{
    /// 我的功能列表视图模型
    private lazy var squareListViewModel = XGSquareListViewModel()
    
    // MARK: - 构造方法
    
    override init(style: UITableView.Style)
    {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpTableView()
        loadData()
    }
    
    // MARK: - 懒加载
    
    /// 设置模型数组
    private lazy var settingGroupModeList = {
         return XGSettingGroupModel.mj_objectArray(withFilename: "SettingInfo.plist") as? [XGSettingGroupModel]
    }()
    /// collectionView
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
}

// MARK: - UITableViewDataSource

extension XGMineTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return settingGroupModeList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settingGroupModeList?[section].items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "ID")
        }
        
        let itemModel = settingGroupModeList?[indexPath.section].items?[indexPath.row]
        cell?.textLabel?.text = itemModel?.title
        if let icon = itemModel?.icon,
           let image = UIImage(named: icon) {
            cell?.imageView?.image = image
        } else {
            cell?.imageView?.image = nil
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let functionName = settingGroupModeList?[indexPath.section].items?[indexPath.item].functionName else {
            return
        }
        
        let selector = NSSelectorFromString(functionName)
        perform(selector)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension XGMineTableViewController:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return squareListViewModel.squareList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSquareCollectionViewCellReuseIdentifier, for: indexPath) as! XGSquareCollectionViewCell
        cell.squareModel = squareListViewModel.squareList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let squareModel = squareListViewModel.squareList[indexPath.item]
        if squareModel.url?.hasPrefix("http://") == true || squareModel.url?.hasPrefix("https://") == true {
            let webViewcontroller = SFSafariViewController(url: URL(string: squareModel.url!)!)
            present(webViewcontroller, animated: true, completion: nil)
        }
    }
}

// MARK: - 其他方法

private extension XGMineTableViewController
{
    /// 加载数据
    func loadData() -> Void
    {
        SVProgressHUD.show()
        squareListViewModel.loadSquareList { (isSuccess) in
            SVProgressHUD.dismiss()
            if !isSuccess {
                XGPrint("加载我的功能列表失败")
                return
            }
            
            // 刷新表格
            self.collectionView.reloadData()
            // 计算有多少行 固定格式 (count - 1) / 列数 + 1
            let rows = (self.squareListViewModel.squareList.count - 1) / kColumns + 1
            let itemWidth = (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width
            // 计算squareCollectionView的高度
            let height = CGFloat(rows) * itemWidth + CGFloat(rows - 1) * kScreenScale
            self.collectionView.height = height
            // 重新给tableView赋值 让tableView自动计算contentSize
            self.tableView.tableFooterView = self.collectionView
        }
    }
    
    /// 跳转到appStore
    @objc func gotoAppStore() -> Void
    {
        guard let appStoreURL = URL(string: "https://itunes.apple.com/cn/app/id1095178677") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func callTelephone() -> Void
    {
        guard let telephoneURL = URL(string: "tel://17300520041") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(telephoneURL) {
            UIApplication.shared.open(telephoneURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func sendMessage() -> Void
    {
        guard let messageURL = URL(string: "sms://17300520041") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(messageURL) {
            UIApplication.shared.open(messageURL, options: [:], completionHandler: nil)
        }
    }
    
    /// 清除缓存
    @objc func clearCache() -> Void
    {
        // 清空cachePath目录
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        FileManager.default.removeFilePath(filePath: cachePath) { (error) in
            if error == nil {
                SVProgressHUD.showSuccess(withStatus: "清除成功")
            }
        }
    }
}

// MARK: - 设置界面

private extension XGMineTableViewController
{
    /// 设置tableView
    func setUpTableView() -> Void
    {
        // 设置组头和组尾高度
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        
        // 设置tableView尾部视图
        collectionView.backgroundColor = UIColor.white
        collectionView.height = 200
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.tableFooterView = collectionView
        
        // 设置内容边距
        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
        
        // 设置collectionView 作为tableFooterView
        setUpCollectionView()
    }
    
    /// 设置collectionView
    private func setUpCollectionView() -> Void
    {
        collectionView.backgroundColor = UIColor(white: 0.94, alpha: 1)
        
        // 布局cell
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let margin:CGFloat = kScreenScale  // 间距
        let columns:CGFloat = 4 // 4列
        var itemWidth = (kScreenWidth - CGFloat(columns - 1) * margin) / CGFloat(columns)
        itemWidth = floor(itemWidth)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = margin
        
        // 注册cell
        collectionView.register(UINib(nibName: "XGSquareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kSquareCollectionViewCellReuseIdentifier)
    }
}
