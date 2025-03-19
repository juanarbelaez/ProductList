//
//  EditProductRouter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation
import UIKit

protocol EditProductRouting {
    var editProductView: EditProductView? { get }
    
    func showEditDetails (fromViewController: UIViewController, withProduct product: ProductDetailEntity )
}
    

class EditProductRouter: EditProductRouting {

    var editProductView: EditProductView?
    
    func showEditDetails(fromViewController: UIViewController, withProduct product: ProductDetailEntity) {
        
        let editProductInteractor = EditProductInteractor()
        let editProductPresenter = EditProductPresenter(productToEdit: product, interactor: editProductInteractor, router: self)
        editProductView = EditProductView(presenter: editProductPresenter)
        editProductPresenter.ui = editProductView
        
        fromViewController.present(editProductView!, animated: true)
        
    }

        
    
}
