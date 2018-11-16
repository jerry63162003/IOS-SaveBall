//
//  MainViewViewController.swift
//  SaveBall
//
//  Created by user04 on 2018/9/1.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import SnapKit

class MainViewViewController: UIViewController {

    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    let gameConfig  = GameConfig.shared
    let defaults = UserDefaults.standard
    
    lazy var settingView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image:#imageLiteral(resourceName: "设置弹窗"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(6)
            make.centerX.equalTo(bgImage.snp.right)
        })
        
        let label1 = UILabel()
        label1.textColor = UIColor.black
        label1.text = "音乐"
        label1.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label1)
        label1.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(75)
            make.top.equalTo(bgImage).offset(129)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.black
        label2.text = "音效"
        label2.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label2)
        label2.snp.makeConstraints({ (make) in
            make.left.equalTo(label1)
            make.top.equalTo(label1.snp.bottom).offset(34)
        })
        
        let musicButton = UIButton()
        musicButton.isSelected = gameConfig.isGameMusic
        musicButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        musicButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        musicButton.tag = 10
        musicButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(musicButton)
        musicButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label1.snp.right).offset(14)
            make.centerY.equalTo(label1)
        })
        
        let soundButton = UIButton()
        soundButton.isSelected = gameConfig.isGameSound
        soundButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        soundButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        soundButton.tag = 11
        soundButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(soundButton)
        soundButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label2.snp.right).offset(14)
            make.centerY.equalTo(label2)
        })
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.tag = 30
        button.setImage(#imageLiteral(resourceName: "关于我们"), for: .normal)
        bgImage.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(label2.snp.bottom).offset(40)
        }
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var highScore = defaults.object(forKey: "highScore") as? String
        if highScore == nil {
            highScore = "00:00.000"
            defaults.set(highScore, forKey: "highScore")
        }
        scoreLabel.text = "最高分:\(highScore!)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        
        if sender.tag == 12 {
            openSetting()
        }
        
        if sender.tag == 30 {
            openWebView()
        }
        
        if sender.tag == 31 {
            settingView.removeFromSuperview()
        }
    }
    
    func openWebView() {
        let webview = WebViewController()
        webview.urlStr = "http://static.mejyh.com/SaveBall/index.html"
        WebViewController.WEBVIEW_HEIGHT = 64
        
        var top = UIApplication.shared.keyWindow?.rootViewController
        while ((top?.presentedViewController) != nil) {
            top = top?.presentedViewController
        }
        top?.present(webview, animated: true, completion: nil)
    }
    
    @objc func settingClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            gameConfig.isGameMusic = sender.isSelected
        }
        if sender.tag == 11 {
            gameConfig.isGameSound = sender.isSelected
        }
    }

    func openSetting() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }

}
