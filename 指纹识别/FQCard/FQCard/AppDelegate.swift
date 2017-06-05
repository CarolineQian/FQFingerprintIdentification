//
//  AppDelegate.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/8.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{


    var window: UIWindow?
    let mainVC = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    //进入后台
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        UserDefaults.standard.set(timeStamp, forKey: "currentTime")
    }
    
    //进入前台
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        print("进入前台")
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let currentTime = UserDefaults.standard.value(forKey: "currentTime")
        if (timeStamp - (currentTime as! Int)) > 5
        {

                mainVC.gestureView.isHidden = false
                mainVC.gestureView.isFirst = false
                mainVC.gestureView.messagerLabel.text = "确认手势密码"
            
            //指纹解锁
            let authenticationContext = LAContext()
            var error: NSError?
            let fingerPrint = UserDefaults.standard.value(forKey: "fingerPrint")
            if ((fingerPrint != nil) && fingerPrint as! Bool)
            {
                //步骤1：检查Touch ID是否可用
                let isTouchIdAvailable = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
                //真机上可以使用,模拟器上不可使用
                if isTouchIdAvailable
                {
                    print("恭喜，Touch ID可以使用！")
                    //回主线程去隐藏View,若是在子线程中隐藏则延迟太厉害
                    //步骤2：获取指纹验证结果
                    authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "需要验证您的指纹来确认您的身份信息", reply:
                        {
                            (success, error) -> Void in
                            if success
                            {
                                print("恭喜，您通过了Touch ID指纹验证！")
                                OperationQueue.main.addOperation
                                    {

                                        self.mainVC.gestureView.isHidden = true
                                        
                                    }
                                return
                                
                            }
                            else
                            {
                                print("抱歉，您未能通过Touch ID指纹验证！\n\(String(describing: error))")
                            }
                    })
                    
                }
                else
                {
                    print("呵呵呵呵呵呵指纹不能用")
                }
                

                
            }
            else
            {
                print("不用指纹解锁")
            }
            
            
            
            
            
            
            
        }

        
    }




}

