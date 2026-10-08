//
//  ViewController.swift
//  NIMSDKSwift
//
//  Created by 姚肖 on 2023/4/23.
//

import UIKit
import AVFoundation
import NIMSDK
import NERtcCallKit
import NERtcCallUIKit

class ViewController: UIViewController, @MainActor NEGroupCallKitDelegate, @MainActor NERtcEngineDelegateEx, @MainActor NECallEngineDelegate {
    
    
    /// 收到邀请的回调
    func onGroupInvited(with info: NEGroupCallInfo) {
        
//        let joinParam = GroupJoinParam()
//        joinParam.callId = info.callId
//        NEGroupCallKit.sharedInstance().groupJoin(joinParam) { error, result in
//            print("===join \(result?.channelId, default: "999")")
//        }
        
    }
    
    func onGroupHangup(withReason reason: String) {
        
    }
    
    func onGroupEndCall(withReason reason: Int, message: String?, callId: String) {
        
    }
    
    nonisolated func onNERtcEngineUser(_ userID: UInt64, audioMuted muted: Bool) {
        print("=== onNERtcEngineUser mute")
    }
    
    nonisolated func onNERtcEngineUserAudioDidStart(_ userID: UInt64) {
        print("=== onNERtcEngineUserAudioDidStart")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let btn = UIButton()
        btn.setTitle("呼叫", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.frame = CGRect(x: 20, y: 100, width: 400, height: 45)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
    
        
        let btn1 = UIButton()
        btn1.setTitle("离开房间", for: .normal)
        btn1.setTitleColor(.orange, for: .normal)
        btn1.frame = CGRect(x: 20, y: 160, width: 400, height: 45)
        btn1.addTarget(self, action: #selector(btnAction1), for: .touchUpInside)
        view.addSubview(btn1)
        
        initSDK()
    }
    
    
    func initSDK() {
        
        // 初始化呼叫组件
        let setupConfig = NESetupConfig(appkey: "")
        NECallEngine.sharedInstance().setup(setupConfig)

        // 初始化 UI 组件
        let config = NECallUIKitConfig()
        NERtcCallUIKit.sharedInstance().setup(with: config)

        // 初始化群呼
        let param = GroupConfigParam()
        param.appid = ""
        param.rtcSafeMode = true
        param.currentUserUid = 1235566
        NEGroupCallKit.sharedInstance().setupGroupCall(param)
        
        let option = NIMSDKOption(appKey: "")

        // 配置 useV1Login
        let v2Option = V2NIMSDKOption()
        // 激活 V10 所有 API，默认使用 V10 的登录接口登录 IM
        v2Option.useV1Login = false

        NIMSDK.shared().register(withOptionV2: option, v2Option: v2Option)
        
        let loginOption = V2NIMLoginOption()
        NIMSDK.shared().v2LoginService.login("ceshi3", token: "123456", option: loginOption) {
            print("=== 登录成功")
        } failure: { error in
            
        }
        
        NEGroupCallKit.sharedInstance().add(self)
        NECallEngine.sharedInstance().addCall(self)
        NECallEngine.sharedInstance().engineDelegate = self
    }
    
    @objc func btnAction() {
        
        // 创建群组通话参数
        let groupCallParam = NEUIGroupCallParam()
        groupCallParam.remoteUsers = ["ceshi8"]

        // 发起群组通话
        NERtcCallUIKit.sharedInstance().groupCall(with: groupCallParam)
    }
    
    @objc func btnAction1() {
        
        
        
    }

}

