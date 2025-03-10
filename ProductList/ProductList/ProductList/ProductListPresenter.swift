//
//  ProductListPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import Foundation

protocol ProductListPresentable: AnyObject {
    var ui: ProductListUI? {get}
    var productViewModels: [ProductViewModel] {get}
    
    func onViewAppear()
    func onTapCell(atIndex: Int)
    func onTapNew()
}

protocol ProductListUI: AnyObject {
    func update(products: [ProductViewModel])
}

class ProductListPresenter: ProductListPresentable {
    
    private let productListInteractor: ProductListInteractable
    weak var ui: ProductListUI?
    private let router: ProductListRouting
    
    var productViewModels: [ProductViewModel] = []
    private var models: ProductResponseEntity = []
    
    init(productListInteractor: ProductListInteractable, router: ProductListRouting ) {
        self.productListInteractor = productListInteractor
        self.router = router
        
    }
    
    func onViewAppear() {
        productListInteractor.getProductList { result in
            switch result {
            case .success(let models):
                self.models = models
                self.productViewModels = models.map {entity in
                    ProductViewModel(productName: entity.title, productCategory: entity.category.rawValue, productPrice: String(entity.price), productImageUrl: entity.image)
                }
                self.ui?.update(products: self.productViewModels)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func onTapCell(atIndex: Int) {
        
        let productId = models[atIndex].id
        router.showDetailProduct(withProductId: productId.description)
    }
    
    func onTapNew() {
        
    }
}
