//
//  ProductDetailView.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation
import UIKit

class ProductDetailView: UIViewController {
    
    let stackview = UIStackView()
    let stackviewH = UIStackView()
    
    let productImageVIew = UIImageView()
    let categoriaLabel = UILabel()
    let nombreLabel = UILabel()
    let precioLabel = UILabel()
    let descripcionLabel = UILabel()
    let divider = UIView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ProductDetailView {
    func style(){
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 15
        
        stackviewH.translatesAutoresizingMaskIntoConstraints = false
        stackviewH.axis = .horizontal
        stackviewH.spacing = 15
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .systemGray4
//        divider.layer.cornerRadius = 10
//        divider.clipsToBounds = true
        
        productImageVIew.translatesAutoresizingMaskIntoConstraints = false
        productImageVIew.image = UIImage(named: "product-placeholder")
        productImageVIew.contentMode = .scaleAspectFit
//        productImageVIew.layer.cornerRadius = 10
//        productImageVIew.clipsToBounds = true

        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
        nombreLabel.text = "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"
        nombreLabel.textAlignment = .left
        nombreLabel.font = UIFont.boldSystemFont(ofSize:24)
        nombreLabel.numberOfLines = 4
        
        categoriaLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriaLabel.text = "Men's clothing"
        categoriaLabel.textColor = .label
        categoriaLabel.textAlignment = .left
        categoriaLabel.font = UIFont.systemFont(ofSize: 16)
        
        precioLabel.translatesAutoresizingMaskIntoConstraints = false
        precioLabel.text = "$109.99"
        precioLabel.textAlignment = .center
        precioLabel.font = UIFont.boldSystemFont(ofSize: 24)
      
        
        descripcionLabel.translatesAutoresizingMaskIntoConstraints = false
        descripcionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        descripcionLabel.textAlignment = .justified
        descripcionLabel.numberOfLines = 0
        descripcionLabel.font = UIFont.systemFont(ofSize: 16)
        
    }
    func layout(){
        
        
        stackviewH.addArrangedSubview(categoriaLabel)
        stackviewH.addArrangedSubview(precioLabel)
        
        
        stackview.addArrangedSubview(productImageVIew)
        stackview.addArrangedSubview(divider)
        stackview.addArrangedSubview(stackviewH)
        stackview.addArrangedSubview(nombreLabel)
        stackview.addArrangedSubview(descripcionLabel)
       
        
        view.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 4),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 4),
//            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackview.bottomAnchor, multiplier: 1),
            divider.widthAnchor.constraint(equalToConstant: 60),
            divider.heightAnchor.constraint(equalToConstant: 4),
            productImageVIew.widthAnchor.constraint(equalToConstant: 300),
            productImageVIew.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
