//
//  ProductListRouter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import Foundation
import UIKit

protocol ProductListRouting: AnyObject {
        var productDetailRouter: ProductDetailRouting? { get }
        var editProductRouter: EditProductRouting? { get }
        var productListView: ProductListView? { get }
        
        
        
        func showProductList(window: UIWindow?)
        func showDetailProduct(withProductId productId: String)
    func showNewProduct(withId id: Int)
}

class ProductListRouter: ProductListRouting {
    
    var editProductRouter: EditProductRouting?
    var productDetailRouter: ProductDetailRouting?
    var productListView: ProductListView?
    
    func showProductList(window: UIWindow?){
        
        self.productDetailRouter = ProductDetailRouter()
        self.editProductRouter = EditProductRouter()
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter(productListInteractor: interactor, router: self)
        
        productListView = ProductListView(presenter: presenter)
        presenter.ui = productListView

        

        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: productListView!)
        window?.rootViewController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        
    }
    
    func showDetailProduct(withProductId productId: String) {
        
        guard let fromViewController = productListView else { return }
        productDetailRouter?.showDetails(fromViewController: fromViewController, withProductId: productId)
    }
    
    
    func showNewProduct(withId id: Int) {
        guard let fromViewController = productListView else { return }
        editProductRouter?.showNewProductDetails(fromViewController: fromViewController, id: id)
    }
}

