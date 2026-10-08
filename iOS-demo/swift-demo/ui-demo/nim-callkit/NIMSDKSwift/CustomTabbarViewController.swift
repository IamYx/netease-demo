import UIKit
import NIMSDK
//import NEConversationUIKit

class CustomTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = ViewController()
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        
        self.viewControllers = [nav]
        
    }
        
}
