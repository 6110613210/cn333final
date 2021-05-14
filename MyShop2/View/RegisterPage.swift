//
//  RegisterPage.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 3/5/2564 BE.
//

import SwiftUI

struct RegisterPage: View {
    
    @Binding var registerStatus: Bool
    @ObservedObject var authen: AuthenticationService
    @State private var name: String = ""
    @State private var cpassword: String = "" //confrim password
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var errorname = ""
    
    var body: some View {
        VStack(spacing: 15){
            Text("Email")
            TextField("", text: $email)        //email field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block email form
            
            Text("Password")
            SecureField("", text: $password)   //password field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block password form
            
            Text("Comfirm Password")
            SecureField("", text: $cpassword)  //password comfirm field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block password comfirm form
            
            Text("Name")
            TextField("", text: $name)         //email field
                .padding(6.5)
                .overlay(RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 1))  // frame block email form
            
        }.padding()
        Button(action:{
            if(cpassword == password){
                authen.signUp(email: email, password: password){
                    (result,errorMessage) in
                    if let error = errorMessage{
                        errorname = error.localizedDescription  // localizedDescription means message error
                        showAlert.toggle()
                    }
                    else{
                        registerStatus.toggle() // state ที่เป็น bool and toggle ก็จะเรียกหน้าใหม่ให้
                    }
                }
            }
            else{
                errorname = "Password & Confrim Password isn't matched"
            }
        }){Text("Finish")}.alert(isPresented: $showAlert) {
            Alert(title: Text(errorname), dismissButton: .default(Text("Got it!")))
        }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage(registerStatus: .constant(true),authen: AuthenticationService())
    }
}
