//
//  ProductRepository.swift
//  MyShop2
//
//  Created by Tham Thearawiboon on 4/5/2564 BE.
//

import Foundation
import Firebase
import FirebaseStorage

class ProductRepository: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var productdb: [Productdb] = []
    private let collectionName = "products"
    
    init() {
        loadAll()
    }
    
    func newProduct(name: String, category: String, uid: String /*pic: String*/,detail: String){
        db.collection(collectionName).addDocument(data: [
            "name": name,
            "category": category,
            "uid" : uid,
            "detail" : detail
            //"pic" : pic
        
        ])
        loadAll()
    }
    
    func upDateProduct(id: String){
        db.collection(collectionName).document(id).updateData([
            "name": "Done"
        ]) { error in
            print(error ?? "Update failed.")
        }

        loadAll()
    }
    
    func remove(at index: Int){
        let todoToDelete = productdb[index]
        db.collection(collectionName).document(todoToDelete.id).delete()
        loadAll()
    }
    
    private func loadAll(){
        db.collection(collectionName).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            guard let documents = snapshot?.documents else {
                return
            }
            self.productdb = documents.compactMap { document in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let category = data["category"] as? String,
                      let uid = data["uid"] as? String,
                      let detail = data["detail"] as? String
                      //let pic = data["pic"] as? UIImage
                else {
                    return nil
                }
                return Productdb(id: document.documentID,
                              name: name,
                              category: category,
                              //pic: pic,
                              uid: uid,
                              detail: detail
                              
                )
            }
            
        }
    }
    
    func fetchData() {
            db.collection("products").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.productdb = documents.map { (queryDocumentSnapshot) -> Productdb in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let detail = data["detail"] as? String ?? ""
                    //let pic = data["pic"]
                    return Productdb(id: id, name: name, category: category, /*pic: pic,*/ uid: uid, detail: detail)
                }
            }
        }
}

