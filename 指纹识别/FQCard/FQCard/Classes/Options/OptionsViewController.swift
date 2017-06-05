//
//  OptionsViewController.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/8.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class OptionsViewController: BaseViewController
{
   
    var gestureView : GestureView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //修改手势密码
        view.addSubview(changeGesturesButton)
        changeGesturesButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        changeGesturesButton.center = CGPoint(x: ScreenWidth / 2, y: ScreenHeight / 2)
        
        //指纹解锁
        view.addSubview(fingerPrintSwitch)
        fingerPrintSwitch.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        fingerPrintSwitch.center = CGPoint(x: ScreenWidth / 2, y: ScreenHeight / 2 + changeGesturesButton.height)
        let fingerPrint = UserDefaults.standard.value(forKey: "fingerPrint")
        if ((fingerPrint != nil) && fingerPrint as! Bool)
        {
            fingerPrintSwitch.isOn = true
        }
        else
        {
            fingerPrintSwitch.isOn = false
        }

    }
    
    override func test()
    {
        gestureView?.removeFromSuperview()
    }
    
    //MARK: - 懒加载
    lazy var changeGesturesButton : UIButton = {
            let btn = UIButton()
            btn.setTitle("修改手势密码", for: UIControlState.normal)
            btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            btn.addTarget(self, action:#selector(changeGesturesButtonAction), for: UIControlEvents.touchUpInside)
            return btn
    }()
    
    lazy var fingerPrintSwitch : UISwitch = {
        let swt = UISwitch()
        swt.onTintColor = UIColor.hexStringToColor(hexString: ColorOfBlueColor)
        swt.tintColor = UIColor.white
        swt.addTarget(self, action: #selector(fingerPrintSwitchAction(swt:)), for: UIControlEvents.valueChanged)
        return swt
    }()
    
    //MARK: - Actions
    func changeGesturesButtonAction()
    {
        print("修改手势密码")
        gestureView = GestureView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), changeGestures: true)
        view.addSubview(gestureView!)
        
    }
    
    func fingerPrintSwitchAction(swt:UISwitch)
    {
        swt.isOn = !swt.isOn
        print("现在是打开还是关闭\(swt.isOn)")
        if swt.isOn
        {
            UserDefaults.standard.set(true, forKey: "fingerPrint")
        }
        else
        {
             UserDefaults.standard.set(false, forKey: "fingerPrint")
        }
    }

    
    
    


}
