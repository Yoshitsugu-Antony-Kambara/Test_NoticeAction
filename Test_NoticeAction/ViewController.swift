//
//  ViewController.swift
//  Test_NoticeAction
//
//  Created by 神原良継 on 2019/05/12.
//  Copyright © 2019 YoshitsuguKambara. All rights reserved.
//

import UIKit
import UserNotifications



// アクションをenumで宣言
enum ActionIdentifier: String {
    case actionOne
    case actionTwo
    case actionThree
}

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    var one: Float = 0.0
    var two: Float = 0.0
    var three: Float = 0.0
    
    var resultOne: String = ""
    var resultTwo: String = ""
    var resultThree: String = ""
    var Result: String = ""
    
    
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var labelResult: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // アクション設定
        let actionOne = UNNotificationAction(identifier: ActionIdentifier.actionOne.rawValue,
                                             title: "投資",
                                             options: [.foreground])
        let actionTwo = UNNotificationAction(identifier: ActionIdentifier.actionTwo.rawValue,
                                             title: "消費",
                                             options: [.foreground])
        let actionThree = UNNotificationAction(identifier: ActionIdentifier.actionThree.rawValue,
                                             title: "浪費",
                                             options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "category_select",
                                              actions: [actionOne, actionTwo, actionThree],
                                              intentIdentifiers: [],
                                              options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        
        let content = UNMutableNotificationContent()
        content.title = "この１時間はどうでしたか？"
        content.body = "時間の使い方を選択してください"
        content.sound = UNNotificationSound.default
        
        // categoryIdentifierを設定
        content.categoryIdentifier = "category_select"
        
        // 60秒ごとに繰り返し通知
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "notification",
                                            content: content,
                                            trigger: trigger)
        
        // 通知登録
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    // アクションを選択した際に呼び出されるメソッド
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: () -> Swift.Void) {
        
        // 選択されたアクションごとに処理を分岐
        switch response.actionIdentifier {
            
        case ActionIdentifier.actionOne.rawValue:
            // 具体的な処理をここに記入
            // 変数oneをカウントアップしてラベルに表示
            one = one + 1.0
            label1.text = String(one)
            
        case ActionIdentifier.actionTwo.rawValue:
            // 具体的な処理をここに記入
            two = two + 1.0
            label2.text = String(two)
        
        case ActionIdentifier.actionThree.rawValue:
            three = three + 1.0
            label3.text = String(three)
            
        default:
            ()
        }
        
        completionHandler()
    }
    
    /****
    resultOne = Double(one / one + two + three)
    resultTwo = Double(two / one + two + three)
    resultThree = Double(three / one + two + three)
    
    print(Int(resultOne * 100.0) + ":" + Int(resultTwo * 100.0) +  ":" +  Int(resultThree * 100.0))
    ***/
    
    
    @IBAction func result(_ sender: Any) {
        resultOne = String(Int((one / (one + two + three)) * 10))
        resultTwo = String(Int((two / (one + two + three)) * 10))
        resultThree = String(Int((three / (one + two + three)) * 10))
        
        Result = resultOne + ":" + resultTwo + ":" + resultThree
        
        labelResult.text = Result
      
    }
    

}

