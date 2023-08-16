import Foundation
import FirebaseAuth

final class AuthViewModel {
    
    static let shared = AuthViewModel()
    
    // MARK: - Create New User
    
    var registerStatus = Dynamic(AccountRegistrationModel(succeed: Bool(), title: "", message: ""))
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.registerStatus.value = AccountRegistrationModel(succeed: false, title: "Registration failed", message: e.localizedDescription)
            } else {
                self.registerStatus.value = AccountRegistrationModel(succeed: true, title: "Registation succed", message: "Go to the SignIn Screen to log into main interface")
            }
        }
    }
    
    // MARK: - LogIn with existing User
    
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
    
    // MARK: - LogOut
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Load current User Data
    
    var userAccountDataStatus = Dynamic(UserData(userName: "", userEmail: ""))
    func loadUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
            self.userAccountDataStatus.value = UserData(userName: user.displayName ?? "New User", userEmail: user.email!)
        }
    }
    
    
    // MARK: - Change Current User Account Info
    
    var paswordChangeStatus = Dynamic("")
    
    func changePassword(newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let e = error {
                self.paswordChangeStatus.value = e.localizedDescription
            } else {
                self.paswordChangeStatus.value = ""
            }
        }
    }
    
    func updateUserDisplayName(name : String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
        }
    }
    
    var emailChangeStatus = Dynamic("")
    var newEmailValue = Dynamic("")
    
    func changeEmail(newEmail: String) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
            if let e = error {
                self.emailChangeStatus.value = e.localizedDescription
            } else {
                self.emailChangeStatus.value = ""
                self.newEmailValue.value = newEmail
            }
        }
    }
    
    var userAvatarURL = Dynamic(URL(string: ""))
    
    func updateUserProfilePhoto(imageUrl : URL) {
        self.userAvatarURL.value = imageUrl
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = imageUrl
        changeRequest?.commitChanges { error in
        }
    }
    
}
