import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = . clear
        navBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = .white
        
        let menuButton : UIButton = {
            let b = UIButton()
            b.setImage(UIImage(named: K.NavigationControllerElements.menuButton), for: .normal)
            b.addTarget(self, action: #selector(menuButtonTaped), for: .touchUpInside)
            return b
        }()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        let avatarImage : UIImageView = {
            let v = UIImageView()
            v.image = UIImage(named: K.userAvatarImg)
            v.widthAnchor.constraint(equalToConstant: 45).isActive = true
            v.contentMode = .scaleToFill
            return v
        }()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarImage)
        
        let logoImage : UIImageView = {
            let v = UIImageView()
            v.image = UIImage(named: K.mainLogoImage)
            v.widthAnchor.constraint(equalToConstant: 45).isActive = true
            v.contentMode = .scaleAspectFill
            return v
        }()
        self.navigationItem.titleView = logoImage
    }
    
    @objc func menuButtonTaped() {
        let menuVC = MenuViewController()
        menuVC.transitioningDelegate = MenuViewController.shared
        menuVC.modalPresentationStyle = .custom
        present(menuVC, animated: true, completion: nil)
    }
    
}
