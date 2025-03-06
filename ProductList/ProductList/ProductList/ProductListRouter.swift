//
//  ProductListRouter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import Foundation
import UIKit

protocol ProductListRouting: AnyObject {
//        var productDetailRouter: ProductDetailRouting? { get }
//        var newProductRouter: NewProductRouting? { get }
        var productListView: ProductListView? { get }
        
        
        
        func showProductList(window: UIWindow?)
//        func showDetailMovie(withMovieId movieId: String)
//        func showNewProduct()
}

class ProductListRouter: ProductListRouting {
    
    var productListView: ProductListView?
    
    func showProductList(window: UIWindow?){
        
//        self.productDetailRouter = ProductDetailRouter()
//        self.newProductRouter = NewProductRouter()
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter(productListInteractor: interactor, router: self)
        
        productListView = ProductListView(presenter: presenter)
        presenter.ui = productListView
//        view.presenter = presenter
        
//        let navigationController = UINavigationController(rootViewController: productListView)
//        window?.rootViewController = navigationController

//        navigationController.navigationBar.prefersLargeTitles = true
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: productListView!)
        window?.rootViewController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        
    }
    
}

