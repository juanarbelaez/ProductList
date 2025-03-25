//
//  ProductDetailRouter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation
import UIKit

protocol ProductDetailRouting {
    
    var editProductRouter: EditProductRouting? { get }
    var productDetailView: ProductDetailView? { get }
    
    func showDetails(fromViewController: UIViewController, withProductId productId: String)
    func showEditDetails(withProductModel product: ProductDetailEntity)
}


class ProductDetailRouter: ProductDetailRouting {
    
    var editProductRouter: EditProductRouting?
    var productDetailView: ProductDetailView?
    
//    cambios
    
    func showDetails(fromViewController: UIViewController, withProductId productId: String) {
        self.editProductRouter = EditProductRouter()
        let productDetailInteractor = ProductDetailInteractor()
        let productDetailPresenter = ProductDetailPresenter(productId: productId, router: self, productDetailInteractor: productDetailInteractor)
        productDetailView = ProductDetailView(presenter: productDetailPresenter)
        productDetailPresenter.ui = productDetailView
        
        fromViewController.navigationController?.pushViewController(productDetailView!, animated: true)
    }
    
    func showEditDetails(withProductModel product: ProductDetailEntity) {
        guard let fromViewController = productDetailView else {
            return
        }
        editProductRouter?.showEditDetails(fromViewController: fromViewController, withProduct: product)
    }
    
   
    
    
    
    
}
    
    
    

