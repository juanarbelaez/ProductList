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
    
    let viewCell = UIView()
    let productImage = UIImageView()
    let nombreLabel = UILabel()
    let categoriaLabel = UILabel()
    let precioLabel = UILabel()
    
    static let reuseID = "ProductListCell"
    static let rowHeight: CGFloat = 168
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray5
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductListCell {
    private func setup(){
        
        viewCell.backgroundColor = .white
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        viewCell.layer.cornerRadius = 10
        viewCell.clipsToBounds = true
    
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "product-placeholder")
        productImage.contentMode = .scaleAspectFit
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
        
        
        
        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
//        nombreLabel.text = "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"
        nombreLabel.textAlignment = .left
        nombreLabel.font = UIFont.boldSystemFont(ofSize:18)
        nombreLabel.numberOfLines = 4
        
        categoriaLabel.translatesAutoresizingMaskIntoConstraints = false
//        categoriaLabel.text = "Men's clothing"
        categoriaLabel.textAlignment = .left
        categoriaLabel.font = UIFont.systemFont(ofSize: 13)
        
        precioLabel.translatesAutoresizingMaskIntoConstraints = false
//        precioLabel.text = "$109.99"
        precioLabel.textAlignment = .center
        precioLabel.font = UIFont.boldSystemFont(ofSize: 18)
        precioLabel.layer.cornerRadius = 10
        precioLabel.clipsToBounds = true
        precioLabel.backgroundColor = .systemGray3
        
        
        
        
    }
    private func layout() {
        
        contentView.addSubview(viewCell)
        viewCell.addSubview(productImage)
        viewCell.addSubview(nombreLabel)
        viewCell.addSubview(categoriaLabel)
        viewCell.addSubview(precioLabel)
        
   

        NSLayoutConstraint.activate([
            viewCell.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            viewCell.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: viewCell.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: viewCell.bottomAnchor, multiplier: 1),
            productImage.topAnchor.constraint(equalToSystemSpacingBelow: viewCell.topAnchor, multiplier: 2),
            productImage.leadingAnchor.constraint(equalToSystemSpacingAfter: viewCell.leadingAnchor, multiplier: 2),
            productImage.widthAnchor.constraint(equalToConstant: 120),
            productImage.heightAnchor.constraint(equalToConstant: 128),
            
            categoriaLabel.topAnchor.constraint(equalToSystemSpacingBelow: viewCell.topAnchor, multiplier: 2),
            categoriaLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: productImage.trailingAnchor, multiplier: 1),
//            viewCell.trailingAnchor.constraint(equalToSystemSpacingAfter: categoriaLabel.trailingAnchor, multiplier: 2),
            
            precioLabel.topAnchor.constraint(equalToSystemSpacingBelow: viewCell.topAnchor, multiplier: 0),
            viewCell.trailingAnchor.constraint(equalToSystemSpacingAfter: precioLabel.trailingAnchor, multiplier: 0),
            precioLabel.heightAnchor.constraint(equalToConstant: 40),
            precioLabel.widthAnchor.constraint(equalToConstant: 96),
            
            nombreLabel.topAnchor.constraint(equalToSystemSpacingBelow: categoriaLabel.topAnchor, multiplier: 4),
            nombreLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: productImage.trailingAnchor, multiplier: 1),
            viewCell.trailingAnchor.constraint(equalToSystemSpacingAfter: nombreLabel.trailingAnchor, multiplier: 1),
            
            
        ])
    }
    
    func configure(model: ProductViewModel) {
        
        guard let url = URL(string: model.productImageUrl) else { return }
        getImage(url: url) { img in
            self.productImage.image = img
        }
        
        nombreLabel.text = model.productName
        categoriaLabel.text = model.productCategory
        precioLabel.text = String(model.productPrice)
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let img = UIImage(data: data) {
                        completion(img)
                    } else {
                        completion(nil)
                    }
                }
            }.resume()
        }
}

