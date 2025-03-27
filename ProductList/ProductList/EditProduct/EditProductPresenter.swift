//
//  EditProductPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation

protocol EditProductUI: AnyObject {
    
    func update(productToEdit: EditProductViewModel)
    func update()
    func dismissEditProductView()
}

protocol EditProductPresentable: AnyObject {
    var ui: EditProductView? { get }
    var productToEdit: ProductDetailEntity? { get }
    var id: Int? { get }
    
    func onViewAppear()
    func onTapSave(model : EditProductViewModel)
}

class EditProductPresenter: EditProductPresentable {
    
    weak var ui: EditProductView?
    var productToEdit: ProductDetailEntity?
    var id: Int?
    
    private let interactor: EditProductInteractor
    private let router: EditProductRouting
    
    init(productToEdit: ProductDetailEntity, interactor: EditProductInteractor, router: EditProductRouting) {
        self.productToEdit = productToEdit
        self.interactor = interactor
        self.router = router
    }
    
    init(id: Int, interactor: EditProductInteractor, router: EditProductRouting) {
        self.id = id
        self.router = router
        self.interactor = interactor
    }
    
    
    
    func onViewAppear() {
        if productToEdit != nil {
            
            let model = mapProduct(productToEdit: productToEdit!)
            self.ui?.update(productToEdit: model)
        } else {
            self.ui?.update()
        }
        
        
    }
    
    func mapProduct(productToEdit: ProductDetailEntity) -> EditProductViewModel {
        
        let editProductViewModel = EditProductViewModel(productName: productToEdit.title, productDescription: productToEdit.description, productCategory: productToEdit.category.rawValue, productPrice: String(productToEdit.price), productImageUrl: productToEdit.image)
        return editProductViewModel
    }
    
    func onTapSave(model : EditProductViewModel) {
        
       
        if productToEdit != nil {
            
            let productDictionary : [String:Any] = [
                "id":productToEdit!.id,
                "title":model.productName,
                "price": Double(model.productPrice) as Any,
                "description":model.productDescription,
                "image":model.productImageUrl,
                "category":model.productCategory]
            
            interactor.updateProduct(productDictionary: productDictionary) { result  in
                switch result {
                case .success(let msg) :
                    print(msg)
                    self.ui?.dismissEditProductView()
                case .failure (let error):
                    print(error)
                }
            }
        } else {
            
            let productDictionary : [String:Any] = [
                "title" : model.productName,
                "price" : Double(model.productPrice) ?? 0.0,
                "description" : model.productDescription,
                "image" : "http://example.com",
                "category" : model.productCategory]
            
            
            interactor.setNewProduct(productDictionary: productDictionary) { result in
                switch result {
                case .success(let msg) :
                    print(msg)
                    self.ui?.dismissEditProductView()
                case .failure (let error):
                    print(error)
                }
            }
        }
    }
    
   
}
