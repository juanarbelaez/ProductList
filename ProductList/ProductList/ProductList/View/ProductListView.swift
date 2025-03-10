//
//  ProductListView.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import UIKit

import UIKit

class ProductListView: UIViewController {
    
    private let presenter: ProductListPresentable

    var tableView = UITableView()
    let newProductButton = UIButton()
    
    
    init(presenter: ProductListPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setup()
        presenter.onViewAppear()
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        
        newProductButton.translatesAutoresizingMaskIntoConstraints = false
        newProductButton.configuration = .filled()
        newProductButton.configuration?.image = UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        newProductButton.configuration?.cornerStyle = .capsule
        newProductButton.configuration?.buttonSize = .large
        newProductButton.addTarget(self, action: #selector(newProductTapped), for: .primaryActionTriggered)
        newProductButton.tintColor = .systemGray4
        

        
        view.addSubview(tableView)
        view.addSubview(newProductButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: newProductButton.bottomAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: newProductButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupNavigationBar(){
        
        title = "Products"
        
    }
}

extension ProductListView: ProductListUI {
    func update(products: [ProductViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.productViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.reuseID, for: indexPath)  as! ProductListCell
        let model = presenter.productViewModels[indexPath.row]
        cell.configure(model: model)

        return cell
    }
}

// MARK: - Actions

extension ProductListView {
    @objc func newProductTapped (sender: UIButton) {
//        TODO enlace a View NuevoProducto
    }
}

