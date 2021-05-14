//
//  AddProductPage.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 4/5/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

struct AddProductView: View {
    var repository: ProductRepository
    @State private var name = ""
    @State private var detail = ""
    @State private var selectedCategory = 0
    @Binding var showAddProductView:Bool
    @State private var showImageUploadView = false
    let myid = Auth.auth().currentUser?.uid
    
    @State var shown = false
    @State var imageURLList = [String]()
    
    private let categoryTypes = ["Car","Smart Phone","Fashion"]

    
    var body: some View {
        
        VStack{
            Text("Add Product").font(.largeTitle)
            TextField("Product Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black)
                .padding()
            Text("Select category")
            Picker("", selection: $selectedCategory){
                ForEach(0..<categoryTypes.count){
                    Text(categoryTypes[$0])
                }
            }
            .pickerStyle(WheelPickerStyle())
            Text("Product Detail")
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        if detail.isEmpty {
                            Text(" Phone : ")
                                .foregroundColor(Color(.label))
                                .padding(.top, 10)
                        }
                        TextEditor(text: $detail)
                            .opacity(detail.isEmpty ? 0.7 : 1)
                    }
                    .padding([.leading, .trailing], 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.systemGray4), lineWidth: 1.2)
                    )
            //-----------------------------
            //------------------------------------------------------------------------
            
            Button(action: {
                repository.newProduct(name: name, category: categoryTypes[selectedCategory],uid: myid!, detail: detail /*pic: imageFileName*/
                )
                showAddProductView = false
            })
            {
                Text("Done")
            }
        }
        .padding()
    }
}
