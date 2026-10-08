//
//  CustomNavViewController.swift
//  NIMSDKSwift
//
//  Created by 姚肖 on 2025/9/28.
//

import UIKit

class CustomNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
          viewController.hidesBottomBarWhenPushed = true
          if children.count > 1 {
            viewController.hidesBottomBarWhenPushed = false
          }
        }
        super.pushViewController(viewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
