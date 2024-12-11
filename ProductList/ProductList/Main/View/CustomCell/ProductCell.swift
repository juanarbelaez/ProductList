//
//  ProductsCell.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/12/24.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configView()
    }
    
    func configView(){
        productImage.layer.cornerRadius = 14
    }
    
    
    func configCell(model: ProductModelElement){
        productTitle.text = model.title
        productCategory.text = model.category.rawValue
        productPrice.text = String(model.price)
    }
    
    
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
