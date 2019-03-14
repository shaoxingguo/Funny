//
//  XGPlayVoiceViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/14.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SDWebImage
import FreeStreamer

class XGVoicePlayerViewController: UIViewController
{
    /// 帖子视图模型
    open var topicViewModel:XGTopicViewModel?
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
        registerNotification()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // 设置图片
        setImageView()
        // 播放音频
//        audioController.play()
    }
    
    // MARK: - 通知监听
    
    // 音频流播放状态发生变化
    @objc private func audioStreamStateChangeNotification(notification:Notification) -> Void
    {
        guard let dict = notification.userInfo else {
            return
        }
        
        let stateVaue = dict[FSAudioStreamNotificationKey_State] as! Int
        let state = FSAudioStreamState(rawValue: stateVaue)!
        switch (state) {
        case .fsAudioStreamRetrievingURL:
            XGPrint("接收到数据...")
        case .fsAudioStreamPlaying:
            //            [self updatePlaybackProgress];
            XGPrint("正在播放")
        case .fsAudioStreamFailed:
            XGPrint("播放失败")
        case .fsAudioStreamPlaybackCompleted:
            XGPrint("播放完成")
        default:
            break
        }
    }
    
    private func updatePlaybackProgress() -> Void
    {
        //        if !isPlaying {
        //
        //        if (self.paused) {//已暂停
        //            [self.audioController.activeStream pause];
        //        }
        //        return;
        //    }
        //    if (!self.audioController.activeStream.continuous) {
        //    FSStreamPosition cur = self.audioController.activeStream.currentTimePlayed;
        //    FSStreamPosition end = self.audioController.activeStream.duration;
        //    CGFloat loadTime = cur.minute *60 + cur.second; //音频已加载播放时长
        //    CGFloat totalTime = end.minute*60 + end.second; //音频总时长
        //    float  prebuffer = (float)self.audioController.activeStream.prebufferedByteCount; //音频已缓存时长
        //    float contentlength = (float)self.audioController.activeStream.contentLength; //音频总时长
        //    }
        //    //每0.5秒刷新获取播放进度
        //    [self performBlock:^{
        //    [self updatePlaybackProgress];
        //    } afterDelay:0.5];
    }
    
    // MARK: - 事件监听
    
    /// 暂停播放按钮
    @IBAction func playOrPauseAction(_ button: UIButton)
    {
        button.isSelected = !button.isSelected
    }
    // MARK: - 私有属性
    
    /// 图片
    private var imageView = UIImageView()
    /// 音频播放器
    private lazy var audioController:FSAudioController = { [weak self] in
        let urlString = self?.topicViewModel?.voiceURL
        let voiceURL = URL(string: urlString!)
        let audioController = FSAudioController(url: voiceURL!)
        return audioController!
        }()
    /// 播放进度
    @IBOutlet private weak var progressSlider:UISlider!
    /// 当前时长
    @IBOutlet private weak var currentTimeLabel: UILabel!
    /// 总时长
    @IBOutlet private weak var totalTimeLabel: UILabel!
}

// MARK: - 音频播放相关

private extension XGVoicePlayerViewController
{
    /// 获取音频是否处于播放状态
    var isPlaying:Bool {
        return audioController.isPlaying()
    }
}

// MARK: - 其他方法

extension XGVoicePlayerViewController
{
    /// 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 设置界面
    private func setUpUI() -> Void
    {
        modalPresentationCapturesStatusBarAppearance = true
        view.addSubview(imageView)
    }
    
    // 注册通知
    private func registerNotification() -> Void
    {
        // 监听音频流播放状态发生变化
        NotificationCenter.default.addObserver(self, selector: #selector(audioStreamStateChangeNotification(notification:)), name: NSNotification.Name.FSAudioStreamStateChange, object: nil)
    }
    
    /// 设置图片
    private func setImageView() -> Void
    {
        guard let imageURL = topicViewModel?.imageURL else {
            return
        }
        
        // 设置高清大图
        if let image =  SDWebImageManager.shared().imageCache?.imageFromCache(forKey: imageURL) {
            // 有大图 设置大图
            setBigImage(image: image)
        } else {
            // 没有大图 进行下载
            SDWebImageManager.shared().loadImage(with: URL(string: imageURL), options: [.retryFailed,.refreshCached], progress: nil) { [weak self] (image, _, error, _, _, _) in
                if error != nil || image == nil {
                    XGPrint("大图下载失败")
                    return
                }
                
                // 设置大图
                self?.setBigImage(image: image!)
            }
        }
    }
    
    /// 设置大图
    private func setBigImage(image:UIImage) -> Void
    {
        imageView.image = image
        // 等比例缩放图片
        let width = view.width
        let height = ceil(width / image.size.width * image.size.height)
        
        imageView.frame = CGRect(x: (view.width - width) / 2, y: 150, width: width, height: height)
    }
}
