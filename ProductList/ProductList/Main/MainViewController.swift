//
//  MainViewController.swift
//  ProductList
//
//  Created by Juan Arbelaez on 9/12/24.
//

import UIKit

class MainViewController: UIViewController {

    
    var productsTableViewController: ProductsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductsTableViewController{
            productsTableViewController = destination
        }
    }
}
