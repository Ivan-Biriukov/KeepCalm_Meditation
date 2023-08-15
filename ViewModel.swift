import Foundation
import FirebaseAuth

final class ViewModel {
    
    static let shared = ViewModel()
    
    var registerStatus = Dynamic(Bool())
    var registerErrorText = Dynamic("")
    
    func registerUser(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.registerStatus.value = false
                self.registerErrorText.value = e.localizedDescription
            } else {
                self.registerStatus.value = true
            }
        }
    }
    
    
    
    
    
    
}
