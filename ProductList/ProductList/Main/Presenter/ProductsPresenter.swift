//
//  ProductsPresenter.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import Foundation

protocol ProductsViewProtocol: AnyObject{
    func getData(list : [Any])
}



class ProductsPresenter {
    
    private var productsList: [Any] = []

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
    
    
    func getProducts() async {
        
        productsList.removeAll()
        
        do{
            let products = try await provider.getProducts()
            
            productsList.append(products)
            
            delegate?.getData(list: productsList)
        }catch{
            
            print(error)
        }
    }
    
}
