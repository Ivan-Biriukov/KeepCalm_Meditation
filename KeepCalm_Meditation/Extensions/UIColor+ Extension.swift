import UIKit

extension UIColor {
    
    // Backgrounds
    static func buttonBackground() -> UIColor? {
        return UIColor(red: 0.49, green: 0.60, blue: 0.57, alpha: 1)
    }
    
    static func mainBackgroundColor() -> UIColor? {
        return UIColor(red: 0.15, green: 0.20, blue: 0.20, alpha: 1)
    }
    
    // Text
    static func grayText() -> UIColor? {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.70)
    }
    
    static func unselectedText() -> UIColor? {
        return UIColor(red: 0.23, green: 0.31, blue: 0.32, alpha: 1)
    }
    
    // UI Elements
    static func statsVCLightIndicatorColor() -> UIColor? {
        return UIColor(red: 0.58, green: 0.80, blue: 0.81, alpha: 1)
    }
    
    static func statsVCDarkIndicatorColor() -> UIColor? {
        return UIColor(red: 0.37, green: 0.50, blue: 0.51, alpha: 0.5)
    }
    
    static func lightGreenGraphColor() -> UIColor? {
        return UIColor(red: 0.66, green: 0.84, blue: 0.44, alpha: 1)
    }
    
    static func darkGreenGraphColor() -> UIColor? {
        return UIColor(red: 0.29, green: 0.54, blue: 0.47, alpha: 1)
    }
}
