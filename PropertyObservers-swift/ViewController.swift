//
//  ViewController.swift
//  PropertyObservers-swift
//
//  Created by Neil Wu on 2017/7/4.
//  Copyright © 2017年 Neil Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var infoTextView = UITextView()
    var segmentedIndex = 0
    var hp : Int = 100 {
        //property observer 屬性變動前要做的事
        willSet {
            
            if segmentedIndex == 0  && hp > 0{
                
                self.inputNewString(String.localizedStringWithFormat("hp監測中 原本hp:%d ", hp))
                
            }
            
        }
        //property observer 屬性變動後要做的事
        didSet {
            
            if segmentedIndex == 0 && hp > 0 {
                
                self.inputNewString(.localizedStringWithFormat("現在hp:%d\n", hp))
                if (hp < 50) {
                    
                    inputNewString("自動喝血程式啟動\n")
                    hp = 100;
                    inputNewString("hp以恢復到100\n")
                    
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hitButton = UIButton.init(type: UIButtonType(rawValue: 0)!)
        hitButton.frame = CGRect.init(x: (self.view.bounds.size.width-100)/2, y: (self.view.bounds.size.height-40)/2, width: 100, height: 40)
        hitButton.addTarget(self, action: #selector(hit(sender:)), for: UIControlEvents.touchUpInside)
        hitButton.setTitle("攻擊", for: UIControlState.normal)
        hitButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        hitButton.layer.borderWidth = 0.3
        hitButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(hitButton)
        
        let segmentItem = ["自動補血", "關閉"]
        let autoHP = UISegmentedControl.init(items: segmentItem)
        autoHP.frame = .init(x: (self.view.bounds.size.width-150)/2, y: 70, width: 150, height: 40)
        autoHP.selectedSegmentIndex = 0;
        autoHP.addTarget(self, action: #selector(changeAuto(sender:)), for: .valueChanged)
        self.view.addSubview(autoHP)
        
        
        infoTextView = UITextView.init(frame: CGRect.init(x: (self.view.bounds.size.width-300)/2, y: hitButton.frame.origin.y+hitButton.frame.size.height+10, width: 300, height: (self.view.bounds.size.height-40)/2 - 20))
        infoTextView.layer.borderWidth = 0.3
        infoTextView.layer.borderColor = UIColor.black.cgColor
        infoTextView.isEditable = false;
        self.view.addSubview(infoTextView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hit(sender:UIButton) {
        
        let random = Int(arc4random_uniform(20));
        if hp - random > 0 {
            hp = hp - random;
            self.inputNewString(.localizedStringWithFormat("============ 剩餘hp:%d\n", hp))
        }
        else {
            hp = 0;
            self.inputNewString(.localizedStringWithFormat("============ 剩餘hp:%d 來不及喝水，你已經死惹\n", hp))
        }
        
    }
    
    func changeAuto(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segmentedIndex = 0
        }
        else {
            segmentedIndex = 1
        }
    }
    
    func inputNewString(_ newStr:String) {
        infoTextView.insertText(newStr)
        infoTextView.scrollRangeToVisible(.init(location: infoTextView.text.characters.count, length: 1))
    }
    
}


