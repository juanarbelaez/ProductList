//
//  ProductListCell.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import Foundation


import Foundation
import UIKit

class ProductListCell: UITableViewCell{
    
    let productImage = UIImageView()
    let nombreLabel = UILabel()
    let categoriaLabel = UILabel()
    let precioLabel = UILabel()
    
    
    let stackViewH = UIStackView()
    let stackViewV = UIStackView()

    
    static let reuseID = "ProductListCell"
    static let rowHeight: CGFloat = 160
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductListCell {
    private func setup(){
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "product-placeholder")
        productImage.contentMode = .scaleAspectFit
        
        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
        nombreLabel.text = "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"
        nombreLabel.textAlignment = .left
        nombreLabel.font = UIFont.boldSystemFont(ofSize:18)
        nombreLabel.numberOfLines = 4
        
        categoriaLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriaLabel.text = "Men's clothing"
        categoriaLabel.textAlignment = .left
        categoriaLabel.font = UIFont.systemFont(ofSize: 13)
        
        precioLabel.translatesAutoresizingMaskIntoConstraints = false
        precioLabel.text = "109.99"
        precioLabel.textAlignment = .left
        precioLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        stackViewH.translatesAutoresizingMaskIntoConstraints = false
        stackViewH.axis = .horizontal
        stackViewH.spacing = 15
        
        stackViewV.translatesAutoresizingMaskIntoConstraints = false
        stackViewV.axis = .vertical
        stackViewV.spacing = 10
    }
    private func layout() {
        
        stackViewV.addArrangedSubview(nombreLabel)
        stackViewV.addArrangedSubview(categoriaLabel)
        stackViewV.addArrangedSubview(precioLabel)
        
        stackViewH.addArrangedSubview(productImage)
        stackViewH.addArrangedSubview(stackViewV)
        
        contentView.addSubview(stackViewH)
        
        NSLayoutConstraint.activate([
            stackViewH.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            stackViewH.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewH.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackViewH.bottomAnchor, multiplier: 3),
            productImage.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
}
