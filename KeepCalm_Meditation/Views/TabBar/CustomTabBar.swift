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

//                tabBarVC.tabBar.selectionIndicatorImage = UIImage(named: K.ButtonsImgs.TabBarButtons.selectedItemBG)
// выставляем цвет картинки выбранного элемента (вкладки) таббара
        tabBarVC.tabBar.tintColor = .white
        
        guard let items = tabBarVC.tabBar.items else {return UITabBarController()}
        
        
        let images = ["Home", K.NavigationControllerElements.soundsButton, K.NavigationControllerElements.profileButton]
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: images[x])
        }
    return tabBarVC
   }
}
