//
//  ProductPage.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 4/5/2564 BE.
//



import SwiftUI
import FirebaseAuth
struct ProductPage: View {
    @ObservedObject var repository: ProductRepository = ProductRepository()
    @State private var showAddProductView = false
    let uid = Auth.auth().currentUser!.uid
    var body: some View {
        //NavigationView
            List {
                ForEach(repository.productdb.filter{$0.uid.lowercased().contains(self.uid.lowercased())}){
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
                .onDelete{ indexSet in todoDeletion(offsets: indexSet)}
                //.onMove{ indices, newOffset in repository.todos.move(fromOffsets: indices, toOffset: newOffset)}
            }
            .navigationBarTitle("My Post")
            .navigationBarItems(
                leading: Button(action: {
                    showAddProductView.toggle()
                }) {
                    Text("Add").frame(alignment: .leading)
                }
                .sheet(isPresented: $showAddProductView){
                    AddProductView(repository: repository, showAddProductView: $showAddProductView)
                },
                trailing: EditButton())
    }
    
    
    
    private func todoDeletion(offsets: IndexSet){
        for index in offsets {
            repository.remove(at: index)
        }
    }
    
    
}

struct ProductView: View{
    var product: Productdb
    var repository: ProductRepository
    var body: some View{
        VStack{
            Text(product.name)
            //Text("User : " + product.uid)
            
            Text("Detail : " + product.detail)
            Image(product.category)
                .resizable()
                .frame(width: 200, height: 200)
        }
        
    }
}


struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage()
    }
}
