//
//  ContentView.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 3/5/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        FirstPage()
    }
}

struct FirstPage: View {
    
    @State private var loginStatus = true
    @ObservedObject var authen = AuthenticationService() // call authenticationService
    
    var body: some View {
        if loginStatus{
            LoginPage(loginStatus: $loginStatus,authen: authen)
        }
        else{
            CategoryPage(authen: authen,loginStatus: $loginStatus)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
