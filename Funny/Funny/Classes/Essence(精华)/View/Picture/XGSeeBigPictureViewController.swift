//
//  XGSeeBigPictureViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SDWebImage

class XGSeeBigPictureViewController: UIViewController
{
    // MARK: - 构造方法
    
    init(topicViewModel:XGTopicViewModel?)
    {
        super.init(nibName: nil, bundle: nil)
        
        self.topicViewModel = topicViewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 控制器生命周期方法
    
    override func loadView()
    {
        super.loadView()
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        setImage()
    }
    
    // MARK: - 事件监听
    
    @objc private func tapImageViewAction() -> Void
    {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 私有属性 && 懒加载
    
    /// 数据模型
    private var topicViewModel:XGTopicViewModel?
    
    /// 大图
    private lazy var bigImageView:FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    /// scrollView
    private lazy var scrollView:UIScrollView = UIScrollView()
}

// MARK: - UIScrollViewDelegate

extension XGSeeBigPictureViewController:UIScrollViewDelegate
{
    // 缩放哪个视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return bigImageView
    }
    
    // 停止缩放
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat)
    {
        // 更新内容边距 要获取缩放视图的大小要使用frame,缩放时frame改变 bounds不改变 缩放时会自动设置contentSize
        var verMargin = (scrollView.height - view!.frame.height) / 2
        verMargin = verMargin < 0 ? 0 : verMargin
        var horMargin = (scrollView.width - view!.frame.width) / 2
        horMargin = horMargin < 0 ? 0 : horMargin
        
        scrollView.contentInset = UIEdgeInsets(top: verMargin, left: horMargin, bottom: verMargin, right: horMargin)
    }
}


 // MARK: - 其他方法

private extension XGSeeBigPictureViewController
{
    /// 设置图片
    func setImage() -> Void
    {
        guard let imageURL = topicViewModel?.imageURL else {
            return
        }
        
        // 设置高清大图
        if let bigImageData = SDWebImageManager.shared().imageCache?.diskImageData(forKey: imageURL){
            // 有大图 设置大图
            setBigImage(imageData: bigImageData)
        } else {
            // 没有大图 进行下载
            SDWebImageManager.shared().loadImage(with: URL(string: imageURL), options: [.retryFailed,.refreshCached], progress: nil) { [weak self] (_, imageData, error, _, _, _) in
                if error != nil || imageData == nil {
                    XGPrint("大图下载失败")
                    return
                }
                
                // 设置大图
                self?.setBigImage(imageData: imageData!)
            }
        }
    }
    
    /// 设置大图
    private func setBigImage(imageData:Data) -> Void
    {
        if topicViewModel?.isGIF == true {
            // gif图片
            bigImageView.animatedImage = FLAnimatedImage(animatedGIFData: imageData)
        } else {
            // 普通图片
            bigImageView.image = UIImage(data: imageData)
        }
        
        // 等比例缩放图片
        let width = scrollView.width
        let height = width / bigImageView.image!.size.width * bigImageView.image!.size.height
        bigImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 设置内容边距
        var margin = (scrollView.height - height) / 2
        margin = margin < 0 ? 0 : margin
        scrollView.contentInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        // 设置滚动范围
        scrollView.contentSize = CGSize(width: 0, height: height)
    }
    
    /// 设置界面
     func setUpUI() -> Void
    {
        view.backgroundColor = UIColor.black
        
        // 添加子控件
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        
        setUpScrollView()
    }
    
    /// 设置scrollView
    func setUpScrollView() -> Void
    {
        // 设置scrollView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        // 设置缩放
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        
        // 设置代理
        scrollView.delegate = self
        
        // 添加imageView
        bigImageView.isUserInteractionEnabled = true
        bigImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageViewAction)))
        scrollView.addSubview(bigImageView)
    }
}
