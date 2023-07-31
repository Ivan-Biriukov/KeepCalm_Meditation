import UIKit

struct CustomTabBar {
    static func createTabBar() -> UITabBarController {

        let tabBarVC = UITabBarController()
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        mainVC.title = nil
        let soundsVC = UINavigationController(rootViewController: MainViewController())
        soundsVC.title = nil
        let profileVC = UINavigationController(rootViewController: MainViewController())
        profileVC.title = nil

        tabBarVC.setViewControllers([mainVC, soundsVC, profileVC], animated: true)
        
        tabBarVC.tabBar.backgroundColor = .clear
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.unselectedItemTintColor = .grayText()
        tabBarVC.tabBar.tintColor = .white
        
        if #available(iOS 13, *) {
            let appearance = tabBarVC.tabBar.standardAppearance.copy()
            appearance.configureWithTransparentBackground()
            tabBarVC.tabBar.standardAppearance = appearance
        } else {
            tabBarVC.tabBar.shadowImage = UIImage()
            tabBarVC.tabBar.backgroundImage = UIImage()
        }
        
        guard let items = tabBarVC.tabBar.items else {return UITabBarController()}
        
        
        let images = [K.NavigationControllerElements.homeButton, K.NavigationControllerElements.soundsButton, K.NavigationControllerElements.profileButton]
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: images[x])
        }
    return tabBarVC
   }
}
