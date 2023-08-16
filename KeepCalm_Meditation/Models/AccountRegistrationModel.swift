import Foundation

struct AccountRegistrationModel {
    let succeed : Bool
    let title : String
    let message : String
}

struct LoginModel {
    let loginSucced : Bool
    let message : String
}

struct UserData {
    let userName : String
    let userEmail : String
  //  let userImageURL : URL
}
