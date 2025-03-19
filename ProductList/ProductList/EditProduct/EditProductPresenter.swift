//
//  EditProductPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation

protocol EditProductUI: AnyObject {
    
    func update(productToEdit: ProductDetailViewModel)
    func update()
}

protocol EditProductPresentable: AnyObject {
    var ui: EditProductView? { get }
    var productToEdit: ProductDetailEntity? { get }
    
    func onViewAppear()
    func onTapSave(productDictionary : [String:AnyHashable])
}

class EditProductPresenter: EditProductPresentable {
    
    weak var ui: EditProductView?
    var productToEdit: ProductDetailEntity?
    
    private let interactor: EditProductInteractor
    private let router: EditProductRouting
    
    init(productToEdit: ProductDetailEntity, interactor: EditProductInteractor, router: EditProductRouting) {
        self.productToEdit = productToEdit
        self.interactor = interactor
        self.router = router
    }
    
   init(interactor: EditProductInteractor, router: EditProductRouting) {
       self.router = router
       self.interactor = interactor
    }
    
    
    
    func onViewAppear() {
        if productToEdit != nil {
            
            let model = mapProduct(productToEdit: productToEdit!)
            self.ui?.update(productToEdit: model)
        }
        
        self.ui?.update()
    }
    
    func mapProduct(productToEdit: ProductDetailEntity) -> ProductDetailViewModel {
        
        let productDetailViewModel = ProductDetailViewModel(productName: productToEdit.title, productDescription: productToEdit.description, productCategory: productToEdit.category.rawValue, productPrice: String(productToEdit.price), productImageUrl: productToEdit.image)
        return productDetailViewModel
    }
    
    func onTapSave(productDictionary : [String:AnyHashable]) {
        if productToEdit != nil {
            
            let id = productToEdit!.id
            interactor.updateProduct(withProductId: id, productDictionary: productDictionary)
        }
        
        interactor.setNewProduct(productDictionary: productDictionary)
        
//      TODO: - Mostrar alert con resultado de Update
    }
}
