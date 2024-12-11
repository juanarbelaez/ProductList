//
//  ProductsTableViewController.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    @IBOutlet var tableViewProducts: UITableView!
    lazy var presenter = ProductsPresenter(delegate: self)
    private var productsList: ProductModel = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        Task{
            await presenter.getProducts()
        }
    }
    
    func configTableView(){
        let nibProduct = UINib(nibName: "\(ProductCell.self)", bundle: nil)
        tableViewProducts.register(nibProduct, forCellReuseIdentifier: "\(ProductCell.self)")
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(productsList.count)
        return productsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let product = productsList[indexPath.row] as? ProductModelElement{
        let product = productsList[indexPath.row]
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else {
                return UITableViewCell()
            }
            productCell.configCell(model: product)
            return productCell
        }
//        return UITableViewCell()
//    }
    
    
    
}

extension ProductsTableViewController : ProductsViewProtocol{
  
    
    func getData(list: ProductModel) {
        productsList = list
        print(productsList)
        tableViewProducts.reloadData()
        }

    
    
}

