import Foundation
import FirebaseAuth

final class ViewModel {
    
    static let shared = ViewModel()
    
    var registerStatus = Dynamic(AccountRegistrationModel(succeed: Bool(), title: "", message: ""))

    func registerUser(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.registerStatus.value = AccountRegistrationModel(succeed: false, title: "Registration failed", message: e.localizedDescription)
            } else {
                self.registerStatus.value = AccountRegistrationModel(succeed: true, title: "Registation succed", message: "Go to the SignIn Screen to log into main interface")
            }
        }
    }
    
    var loginStatus = Dynamic(LoginModel(loginSucced: Bool(), message: ""))
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.loginStatus.value = LoginModel(loginSucced: false, message: e.localizedDescription)
            } else {
                self.loginStatus.value = LoginModel(loginSucced: true, message: "")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    var userAccountDataStatus = Dynamic(UserData(userName: "", userEmail: ""))
    
    func loadUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
              multiFactorString += info.displayName ?? "[DispayName]"
            }
            self.userAccountDataStatus.value = UserData(userName: multiFactorString, userEmail: user.email!)
        }
    }
    
    
    
    
}
