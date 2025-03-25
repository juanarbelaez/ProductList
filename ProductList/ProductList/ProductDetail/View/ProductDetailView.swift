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
    let stackViewButtons = UIStackView()
    
    let editButton = UIButton()
    let deleteButton = UIButton()
    
    let productImageView = UIImageView()
    let categoriaLabel = UILabel()
    let nombreLabel = UILabel()
    let precioLabel = UILabel()
    let descripcionLabel = UILabel()
    let divider = UIView()
    
    
    private let presenter: ProductDetailPresentable
    
    init(presenter: ProductDetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        style()
        layout()
        presenter.onViewAppear()
    }
}

extension ProductDetailView {
    
    
    
    func style(){
        
        view.backgroundColor = .white
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtons.axis = .horizontal
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.configuration = .plain()
        editButton.configuration?.image = UIImage(systemName: "square.and.pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        editButton.configuration?.cornerStyle = .capsule
        editButton.configuration?.buttonSize = .large
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.configuration = .plain()
        deleteButton.configuration?.image = UIImage(systemName: "trash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        deleteButton.configuration?.cornerStyle = .capsule
        deleteButton.configuration?.buttonSize = .large
//        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .primaryActionTriggered)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 15
        
        stackviewH.translatesAutoresizingMaskIntoConstraints = false
        stackviewH.axis = .horizontal
        stackviewH.spacing = 15
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .systemGray4

        productImageView.translatesAutoresizingMaskIntoConstraints = false
//        productImageVIew.image = UIImage(named: "product-placeholder")
        productImageView.contentMode = .scaleAspectFit


        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
        nombreLabel.text = ""
        nombreLabel.textAlignment = .left
        nombreLabel.font = UIFont.boldSystemFont(ofSize:24)
        nombreLabel.numberOfLines = 4
        
        categoriaLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriaLabel.text = ""
        categoriaLabel.textColor = .label
        categoriaLabel.textAlignment = .left
        categoriaLabel.font = UIFont.systemFont(ofSize: 16)
        
        precioLabel.translatesAutoresizingMaskIntoConstraints = false
        precioLabel.text = ""
        precioLabel.textAlignment = .center
        precioLabel.font = UIFont.boldSystemFont(ofSize: 24)
      
        
        descripcionLabel.translatesAutoresizingMaskIntoConstraints = false
        descripcionLabel.text = ""
        descripcionLabel.textAlignment = .justified
        descripcionLabel.numberOfLines = 7
        descripcionLabel.font = UIFont.systemFont(ofSize: 16)
        
    }
    func layout(){
        
        stackViewButtons.addArrangedSubview(editButton)
        stackViewButtons.addArrangedSubview(deleteButton)
        
        stackviewH.addArrangedSubview(categoriaLabel)
        stackviewH.addArrangedSubview(precioLabel)
        
        
        stackview.addArrangedSubview(productImageView)
        stackview.addArrangedSubview(divider)
        stackview.addArrangedSubview(stackviewH)
        stackview.addArrangedSubview(nombreLabel)
        stackview.addArrangedSubview(descripcionLabel)
       
        
        view.addSubview(stackview)
        view.addSubview(stackViewButtons)
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 6),
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 4),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 4),
            divider.heightAnchor.constraint(equalToConstant: 4),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            stackViewButtons.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewButtons.trailingAnchor, multiplier: 1)
        ])
    }
}


extension ProductDetailView: ProductDetailUI{
    func update(productDetail: ProductDetailViewModel) {
        
        guard let url = URL(string: productDetail.productImageUrl) else { return }
        getImage(url: url) { img in
            self.productImageView.image = img
        }
        
        categoriaLabel.text = productDetail.productCategory
        nombreLabel.text = productDetail.productName
        precioLabel.text = "$\(productDetail.productPrice)"
        descripcionLabel.text = productDetail.productDescription
    
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

// MARK: - Actions

extension ProductDetailView {
    
    @objc func editTapped (sender: UIButton) {
        presenter.onTapEdit()
    }
    
}
