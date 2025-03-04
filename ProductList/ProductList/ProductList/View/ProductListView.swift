//
//  ProductListView.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import UIKit

import UIKit

class ProductListView: UIViewController {

    var tableView = UITableView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setup()
    }
}

extension ProductListView {
    
    private func setup() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProductListCell.self, forCellReuseIdentifier: ProductListCell.reuseID)
        tableView.rowHeight = ProductListCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar(){
        
    }
}

extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.reuseID, for: indexPath)  as! ProductListCell
        return cell
    }
}

