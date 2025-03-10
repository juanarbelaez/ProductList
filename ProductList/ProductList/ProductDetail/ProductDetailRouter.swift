//
//  ProductDetailRouter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation
import UIKit

protocol ProductDetailRouting {
    
//    var editRouter: EditRouting? { get }
    var productDetailView: ProductDetailView? { get }
    
    func showDetails(fromViewController: UIViewController, withProductId productId: String)
//    func showEditDetails(withProductModel product: ProductDetailEntity)
}


class ProductDetailRouter: ProductDetailRouting {
    
    
    var productDetailView: ProductDetailView?
    
    func showDetails(fromViewController: UIViewController, withProductId productId: String) {
        let productDetailInteractor = ProductDetailInteractor()
        let productDetailPresenter = ProductDetailPresenter(productId: productId, router: self, productDetailInteractor: productDetailInteractor)
        productDetailView = ProductDetailView(presenter: productDetailPresenter)
        productDetailPresenter.ui = productDetailView
        
        fromViewController.present(productDetailView!, animated: true)
    }
}
    
    
    

