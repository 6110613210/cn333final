//
//  LoginPage.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 3/5/2564 BE.
//

import SwiftUI

struct LoginPage: View {
    
    @Binding var loginStatus: Bool
    @ObservedObject var authen: AuthenticationService
    @State private var registerStatus = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var errorname = ""
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 32){
            
            Image("MyShop")
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(20)  // Logo
            
            Text("MyShop").font(.system(size: 45.0))
            
            TextField("Enter Email", text: $email)   //username field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block username form
            
            SecureField("Enter Password", text: $password)  //password field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block password form
            
            Button(action: {
                authen.signIn(email: email, password: password){
                    (result,errorMessage) in
                    if let error = errorMessage{
                        errorname = error.localizedDescription  // localizedDescription means message error
                        showAlert.toggle()
                    }
                    else{
                        loginStatus.toggle() // state ที่เป็น bool and toggle ก็จะเรียกหน้าใหม่ให้
                    }
                }
            }){Text("Login")}.alert(isPresented: $showAlert) {
                Alert(title: Text(errorname), dismissButton: .default(Text("Got it!"))) 
            }
            
            Button(action: {
                registerStatus.toggle()
            }){Text("Register")}
            .sheet(isPresented: $registerStatus)
                {RegisterPage(registerStatus: $registerStatus,authen: authen)}
        }.padding()
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(loginStatus: .constant(true),authen: AuthenticationService())
    }
}
