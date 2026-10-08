//
//  ChatViewController.swift
//  NIMSDKSwift
//
//  Created by 姚肖 on 2024/3/18.
//

import UIKit
import NIMSDK

class ChatViewController: P2PChatViewController {
    
    let customMessageType = 20

    override func viewDidLoad() {
        
        NEKitChatConfig.shared.ui.chatInputMenu = { [weak self] menuList in
          // 新增
            let itemNew = NEMoreItemModel()
            itemNew.customImage = UIImage(named: "mine_collection")
            itemNew.customDelegate = self
            itemNew.action = #selector(self?.customClick)
            itemNew.title = "自定义消息"
            menuList.append(itemNew)
        }
        
        NEChatUIKitClient.instance.regsiterCustomCell(["\(customMessageType)": CustomChatCell.self])
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    
    func customClick() {
        let data = ["type": customMessageType]
        let attachment = CustomAttachment(customType: customMessageType, cellHeight: 100, data: data)
        let randomNum = Int.random(in: 0...3)
        attachment.goodsName = NIMSDK.shared().loginManager.currentAccount()
        attachment.goodsName = "\(randomNum)"
        let message = NIMMessage()
        let object = NIMCustomObject()
        object.attachment = attachment
        message.messageObject = object
        
        NIMSDK.shared().chatManager.send(message, to: viewmodel.session) { error in
          print("send custom message error : ", error?.localizedDescription as Any)
        }
        
    }

}
