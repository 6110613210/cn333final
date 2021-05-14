//
//  AuthenticationService.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 3/5/2564 BE.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
  @Published var user: User?
  var cancellable: AuthStateDidChangeListenerHandle?

  init() {
    cancellable = Auth.auth().addStateDidChangeListener { (_, user) in
      if let user = user {
        self.user = User(uID: user.uid, eMail: user.email ?? "" , Name: user.displayName ?? "")
      }
      else {
        self.user = nil
      }
    }
  }

  func signUp(
    email: String,
    password: String,
    handler: @escaping AuthDataResultCallback
  ) {
    Auth.auth().createUser(withEmail: email, password: password, completion: handler)
  }

  func signIn(
    email: String,
    password: String,
    handler: @escaping AuthDataResultCallback // Escape means run to instruction line 37 finish and wait to authentication complete
  ) {
    Auth.auth().signIn(withEmail: email, password: password, completion: handler) // handler is function
  }

  func signOut(){
    do{
        try Auth.auth().signOut()
        self.user = nil
    }
    catch{
        
    }
  }
}

struct User{
    
    private var uid: String
    private var email: String
    private var name: String
    
    init(uID : String ,eMail: String,Name: String){
        uid = uID
        email = eMail
        name = Name
    }
    
}
