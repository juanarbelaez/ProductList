//
//  ProductsPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import Foundation

protocol ProductsViewProtocol: AnyObject{
    func getData(list : ProductModel)
}



class ProductsPresenter {
    
//    private var productsList: ProductModel = []

    var provider: ProductsProviderProtocol
    weak var delegate : ProductsViewProtocol?
    
    init(delegate : ProductsViewProtocol, provider: ProductsProvider = ProductsProvider()){
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppWithMock{
            self.provider = ProductsProviderMock()
        }
        #endif
        
        
        
    }
    
    @MainActor
    func getProducts() async {
        
//        productsList.removeAll()
        
        do{
            let products = try await provider.getProducts()
            
//            productsList = products
            delegate?.getData(list: products)
        }catch{
            print(error)
        }
    }
    
}
