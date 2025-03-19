//
//  EditProductInteractor.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation

protocol EditProductInteractable: AnyObject {
    
    func setNewProduct(productDictionary : [String:AnyHashable])
    func updateProduct(withProductId id: Int, productDictionary : [String:AnyHashable])
}


class EditProductInteractor: EditProductInteractable {
    func setNewProduct(productDictionary: [String : AnyHashable]) {
        
    }
    
    func updateProduct(withProductId id: Int, productDictionary: [String : AnyHashable]) {
        let requestModel = RequestModel(endpoint: .products, httpMethod: .PUT)
        let url = requestModel.getURL()
        let id = id
        
        var urlRequest = URLRequest(url: URL(string: url+"\(String(describing: id))")!)
 
        let requestBody = try? JSONSerialization.data(withJSONObject: productDictionary)
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
      
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error   in
            guard let data = data, error == nil else {
                return
            }
            print(data)
            do {
               
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}
