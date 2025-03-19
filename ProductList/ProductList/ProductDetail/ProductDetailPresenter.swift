//
//  ProductDetailPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation

protocol ProductDetailUI: AnyObject {
    func update(productDetail: ProductDetailViewModel)
}

protocol ProductDetailPresentable: AnyObject {
    var ui: ProductDetailUI? {get}
    var productId: String {get}
    
    func onViewAppear()
    func onTapEdit()
}


class ProductDetailPresenter: ProductDetailPresentable {
    
    
    let productId: String
    private let productDetailInteractor: ProductDetailInteractor
    weak var ui: ProductDetailUI?
    private let router: ProductDetailRouting
    
    var model: ProductDetailEntity = ProductDetailEntity(id: 0, title: "", price: 0.0, category: ProductDetailEntity.Category.menSClothing, description: "", image: "")
    var productDetailViewModel = ProductDetailViewModel(productName: "", productDescription: "", productCategory: "", productPrice: "", productImageUrl: "")
    
    
    init(productId: String, router: ProductDetailRouting, productDetailInteractor: ProductDetailInteractor) {
        self.productDetailInteractor = productDetailInteractor
        self.productId = productId
        self.router = router
    }
    
    
    func onViewAppear() {
        
        productDetailInteractor.getProductDetail(withId: productId) { result in
            switch result {
            case .success(let model):
                self.model = model
                self.productDetailViewModel.productName = model.title
                self.productDetailViewModel.productDescription = model.description
                self.productDetailViewModel.productCategory = model.category.rawValue
                self.productDetailViewModel.productPrice = String(model.price)
                self.productDetailViewModel.productImageUrl = model.image
                
                self.ui?.update(productDetail: self.productDetailViewModel)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func onTapEdit() {
        router.showEditDetails(withProductModel: model)
    }
    
    
}


