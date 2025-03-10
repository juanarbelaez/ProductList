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
//        var newProductRouter: NewProductRouting? { get }
        var productListView: ProductListView? { get }
        
        
        
        func showProductList(window: UIWindow?)
        func showDetailProduct(withProductId productId: String)
//        func showNewProduct()
}

class ProductListRouter: ProductListRouting {
    
    var productDetailRouter: ProductDetailRouting?
    var productListView: ProductListView?
    
    func showProductList(window: UIWindow?){
        
        self.productDetailRouter = ProductDetailRouter()
//        self.newProductRouter = NewProductRouter()
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
    
}

