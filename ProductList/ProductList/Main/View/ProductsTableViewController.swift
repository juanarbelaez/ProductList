//
//  ProductsTableViewController.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    lazy var presenter = ProductsPresenter(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .gray
        Task{
            await presenter.getProducts()
        }
    }
    
    
}

extension ProductsTableViewController : ProductsViewProtocol{
    func getData(list: [Any]) {
        print("list:", list)
    }
    
    
}

