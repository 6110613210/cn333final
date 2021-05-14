//
//  ProductPage.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 4/5/2564 BE.
//


import SwiftUI
import FirebaseAuth

struct Smartphone: View {
    
    @ObservedObject var repository: ProductRepository = ProductRepository()
    @State private var showAddProductView = false
    var txt = "Smart Phone"
    
    var body: some View {
        //NavigationView {
        List {
            ForEach(repository.productdb.filter{$0.category.lowercased().contains(self.txt.lowercased())}){
                product in NavigationLink(destination: ProductView(product: product, repository: repository)){
                    HStack{
                        Image(product.category)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(product.name)
                    }
                }
                .onLongPressGesture {
                    repository.upDateProduct(id: product.id)
                }
            }
            //.onDelete{ indexSet in todoDeletion(offsets: indexSet)}
            //.onMove{ indices, newOffset in repository.todos.move(fromOffsets: indices, toOffset: newOffset)}
        }
        .navigationBarTitle("Smartphone")
    }
}

        struct Smartphone_Previews: PreviewProvider {
            static var previews: some View {
                Smartphone()
            }
        }
