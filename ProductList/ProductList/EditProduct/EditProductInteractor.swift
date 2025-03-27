//
//  EditProductInteractor.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation 


protocol EditProductInteractable: AnyObject {
    
    func setNewProduct(productDictionary : [String:Any], completion: @escaping (Result<Any, Error>) -> Void)
    func updateProduct(productDictionary: [String: Any], completion: @escaping (Result<Any, Error>) -> Void)
}


class EditProductInteractor: EditProductInteractable {
    
    func setNewProduct(productDictionary: [String : Any], completion: @escaping (Result<Any, Error>) -> Void) {
        
        let requestModel = RequestModel(endpoint: .products, httpMethod: .POST)
        let url = requestModel.getURL()
        var urlRequest = URLRequest(url: URL(string: url)!)
       
        urlRequest.httpMethod = requestModel.httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            let requestBody = try JSONSerialization.data(
            withJSONObject: productDictionary,
            options: [.prettyPrinted, .sortedKeys])
            urlRequest.httpBody = requestBody
        } catch {
            completion(.failure(error))
            return
        }
        

        URLSession.shared.dataTask(with: urlRequest) { _, response, error in
            DispatchQueue.main.async {
                
                guard let response  = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(error!))
                    return
                }
                    
                if response.statusCode == 200 {
                        completion(.success("El Producto ha sido agragado con exito"))
                }
                
            }
        }.resume()
    }
    
    func updateProduct(productDictionary: [String: Any], completion: @escaping (Result<Any, Error>) -> Void) {
       
        let requestModel = RequestModel(endpoint: .products, httpMethod: .PUT)
        let url = requestModel.getURL(withId: String(describing: productDictionary["id"]!))
        var urlRequest = URLRequest(url: URL(string: url)!)
 
        let requestBody = try? JSONSerialization.data(withJSONObject: productDictionary)
        urlRequest.httpMethod = requestModel.httpMethod.rawValue
        urlRequest.httpBody = requestBody
        

        URLSession.shared.dataTask(with: urlRequest) { _, response, error   in
          
            DispatchQueue.main.async {
                
                guard let response  = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                if response.statusCode == 200 {
                    completion(.success("El Producto ha sido editado con exito"))
                }
            }
        }.resume()
    }
}
