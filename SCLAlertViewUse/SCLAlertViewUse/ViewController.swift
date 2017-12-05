//
//  ViewController.swift
//  SCLAlertViewUse
//
//  Created by 黄家树 on 2017/12/4.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit
import SCLAlertView

let kSuccessTitle = "Congratulations"
let kErrorTitle = "Connection error"
let kNoticeTitle = "Notice"
let kWarningTitle = "Warning"
let kInfoTitle = "Info"
let kSubtitile = "You've just display the awesome Pop Up View"
let kDefaultAnimationDuration = 2.0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getStartedClick(_ sender: Any) {
        SCLAlertView().showInfo("Important info", subTitle: "You are so greate!")
    }
    
    
    @IBAction func showSuccess(_ sender: UIButton) {
        let alert = SCLAlertView()
        _ = alert.addButton("First Button", target: self, selector: #selector(firstButton))
        _ = alert.addButton("Second Button", action: {
            print("Second button tapped")
        })
        _ = alert.showSuccess(kSuccessTitle, subTitle: kSubtitile)
    }
   
    @IBAction func showError(_ sender: UIButton) {
        _ = SCLAlertView().showError("Hold On...", subTitle: "there is someting you haven't done,please do it fisrt",closeButtonTitle: "OK")
    }
    
    @IBAction func showNotice(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive:true)
        _ = SCLAlertView(appearance:appearance).showNotice(kNoticeTitle, subTitle: kSubtitile)
    }
    
    @IBAction func showWarning(_ sender: UIButton) {
        _ = SCLAlertView().showWarning(kWarningTitle, subTitle: kSubtitile)
    }

    @IBAction func showInfo(_ sender: UIButton) {
        _ = SCLAlertView().showInfo(kInfoTitle, subTitle: kSubtitile)
    }
    
    @IBAction func showEdit(_ sender: Any) {
        let appearanace = SCLAlertView.SCLAppearance(showCloseButton:true)
        let alert = SCLAlertView(appearance: appearanace)
        let txt = alert.addTextField("Enter your name")
        _ = alert.addButton("Show Name"){
            print("Text value: \(txt.text ?? "NA")")
        }
        _ = alert.showEdit(kInfoTitle, subTitle: kSubtitile)
    }
    
    
    @IBAction func showCustomSubview(_ sender: UIButton) {
        // 创建显示配置
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont:UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont:UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont:UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton:false,
            dynamicAnimatorActive:true
        )
        
        // 使用自定义显示配置创建弹出框
        let alert = SCLAlertView(appearance: appearance)
        
        //创建子视图
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 216, height: 70))
        let x = (subview.frame.width - 180 ) / 2
        
        //添加一个输入框
        let textfield1 = UITextField(frame: CGRect(x: x, y: 10, width: 180, height: 25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)
        
        //添加第二个输入框
        let textfield2 = UITextField(frame: CGRect(x: x, y: textfield1.frame.maxY + 10, width: 180, height: 25))
        textfield2.isSecureTextEntry = true
        textfield2.layer.borderColor = UIColor.green.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        //设置弹框的自定义视图属性
        alert.customSubview = subview
        
        _ = alert.addButton("Login", action: {
            print("Logged in")
        })
        
        //添加超时按钮
        let showTimeout = SCLButton.ShowTimeoutConfiguration(prefix:"(",suffix:"s)")
        _ = alert.addButton("Timeout Button", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showTimeout: showTimeout) {
            print("Timeout button tapped")
        }
        
        let timeoutValue: TimeInterval = 10.0
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
            print("Timeout occurred")
        }
        
        //显示
        alert.showInfo("Login", subTitle: "", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction))
    }
    
    @IBAction func showCustomAlert(_ sender: UIButton) {
        // 创建显示配置
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont:UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont:UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont:UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton:false,
            dynamicAnimatorActive:true,
            buttonsLayout: .horizontal
        )
        
        let alert = SCLAlertView(appearance:appearance)
        _ = alert.addButton("First Button", target: self, selector: #selector(firstButton))
        _ = alert.addButton("Second Button", action: {
            print("Second button tapped")
        })
        let icon = UIImage(named: "custom_icon.png")
        let color = UIColor.orange
        
        _ = alert.showCustom("Custom color", subTitle: "Custom color", color: color, icon: icon!)
        
    }

    @IBAction func showWait(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton:false
        )
        let alert = SCLAlertView(appearance:appearance).showWait("DownLoad", subTitle: "Processing...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.setSubTitle("Progress: 10%")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 , execute: {
                alert.setSubTitle("Progress: 30%")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    alert.setSubTitle("Progress: 50%")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                        alert.setSubTitle("Progress: 70%")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                            alert.setSubTitle("Progress: 90%")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                alert.close()
                            }
                            
                        })

                    })
                    
                    
                })

            })
        }
        
    }

    @objc func firstButton() {
        print("First button tapped!")
    }
    
}

