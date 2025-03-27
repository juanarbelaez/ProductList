//
//  EditProductView.swift
//  ProductList
//
//  Created by Juan Arbelaez on 10/03/25.
//

import Foundation

import UIKit

class EditProductView: UIViewController {
    
    let stackview = UIStackView()
    let stackviewH = UIStackView()
    let precioStackView = UIStackView()
    let categoriaStackView = UIStackView()
    
    let cambiarImagenButton = UIButton()
    let imagePicker = UIImagePickerController()
    
    let productImageView = UIImageView()
    let nombreTextField = UITextField()
    let categoriaButton = UIButton()
    let precioTextField = UITextField()
    let descripcionTextView = UITextView()
    let saveButton = UIButton()
    
    var category = ""
        
    let categoriaLabel = UILabel()
    let nombreLabel = UILabel()
    let precioLabel = UILabel()
    let descripcionLabel = UILabel()
    
    lazy var alert : UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.okTapped()
        }))
                                        
//                                        { [weak self] _ in
//            self?.okTapped()
//        }))
        return alert
    }()
    
    
    private let presenter: EditProductPresentable
    
    init(presenter: EditProductPresentable) {
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

extension EditProductView {
    func style(){
        view.backgroundColor = .white
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        cambiarImagenButton.translatesAutoresizingMaskIntoConstraints = false
        cambiarImagenButton.configuration = .plain()
        cambiarImagenButton.configuration?.image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        cambiarImagenButton.configuration?.cornerStyle = .capsule
        cambiarImagenButton.configuration?.buttonSize = .large
        cambiarImagenButton.addTarget(self, action: #selector(cambiarImagenTapped), for: .touchUpInside)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 5
        
        stackviewH.translatesAutoresizingMaskIntoConstraints = false
        stackviewH.axis = .horizontal
        stackviewH.spacing = 15
        
        precioStackView.translatesAutoresizingMaskIntoConstraints = false
        precioStackView.axis = .vertical
        precioStackView.spacing = 5
        
        categoriaStackView.translatesAutoresizingMaskIntoConstraints = false
        categoriaStackView.axis = .vertical
        categoriaStackView.spacing = 5
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.image = UIImage(named: "photo-placeholder")
        productImageView.contentMode = .scaleAspectFit
        
        nombreLabel.translatesAutoresizingMaskIntoConstraints = false
        nombreLabel.text = "Nombre"
        nombreLabel.textAlignment = .left
        
        nombreTextField.translatesAutoresizingMaskIntoConstraints = false
        nombreTextField.layer.cornerRadius = 5
        nombreTextField.clipsToBounds = true
        nombreTextField.backgroundColor = .systemGray6
        nombreTextField.tintColor = .black
        nombreTextField.borderStyle = .roundedRect
        
        precioLabel.translatesAutoresizingMaskIntoConstraints = false
        precioLabel.text = "Precio"
        precioLabel.textAlignment = .left
        
        precioTextField.translatesAutoresizingMaskIntoConstraints = false
        precioTextField.layer.cornerRadius = 5
        precioTextField.clipsToBounds = true
        precioTextField.backgroundColor = .systemGray6
        precioTextField.tintColor = .black
        precioTextField.borderStyle = .roundedRect

        
        descripcionLabel.translatesAutoresizingMaskIntoConstraints = false
        descripcionLabel.text = "Descripción"
        descripcionLabel.textAlignment = .left
        
        descripcionTextView.translatesAutoresizingMaskIntoConstraints = false
        descripcionTextView.textAlignment = .justified
        descripcionTextView.font = UIFont.systemFont(ofSize: 17)
        descripcionTextView.layer.cornerRadius = 5
        descripcionTextView.clipsToBounds = true
        descripcionTextView.backgroundColor = .systemGray6
        descripcionTextView.tintColor = .black
        

        
        
        categoriaLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriaLabel.text = "Categoría"
        categoriaLabel.textAlignment = .left
        
        categoriaButton.translatesAutoresizingMaskIntoConstraints = false
        categoriaButton.menu = configureMenu()
        categoriaButton.configuration = .filled()
        categoriaButton.layer.cornerRadius = 5
        categoriaButton.tintColor = .systemGray6
        categoriaButton.clipsToBounds = true
        categoriaButton.showsMenuAsPrimaryAction = true
        categoriaButton.setTitleColor(.black, for: [])
        
        
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.configuration = .filled()
        saveButton.setTitle("Guardar", for: [])
        saveButton.configuration?.imagePadding = 8
        saveButton.tintColor = .systemGray4
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .primaryActionTriggered)
        
    }
    func layout(){
        
        precioStackView.addArrangedSubview(precioLabel)
        precioStackView.addArrangedSubview(precioTextField)
        
        categoriaStackView.addArrangedSubview(categoriaLabel)
        categoriaStackView.addArrangedSubview(categoriaButton)
        
        stackviewH.addArrangedSubview(precioStackView)
        stackviewH.addArrangedSubview(categoriaStackView)
        
        stackview.addArrangedSubview(productImageView)
        stackview.addArrangedSubview(nombreLabel)
        stackview.addArrangedSubview(nombreTextField)
        stackview.addArrangedSubview(stackviewH)
        stackview.addArrangedSubview(descripcionLabel)
        stackview.addArrangedSubview(descripcionTextView)
        
        view.addSubview(stackview)
        view.addSubview(saveButton)
        view.addSubview(cambiarImagenButton)
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 6),
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 4),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 4),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            descripcionTextView.heightAnchor.constraint(equalToConstant: 194),
            saveButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: saveButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: saveButton.bottomAnchor, multiplier: 0),
            cambiarImagenButton.topAnchor.constraint(equalToSystemSpacingBelow: productImageView.topAnchor, multiplier: 0),
            productImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: cambiarImagenButton.trailingAnchor, multiplier: 1)
        ])
    }
    
    func configureMenu() -> UIMenu {
        
        let electronics = UIAction(title: "electronics") { action  in
            self.category = "electronics"
            self.categoriaButton.setTitle(self.category, for: [])
        }
        let jewelery = UIAction(title: "jewelery") { action  in
            self.category = "jewelery"
            self.categoriaButton.setTitle(self.category, for: [])
        }
        let mensClothing = UIAction(title: "men's clothing") { action  in
            self.category = "men's clothing"
            self.categoriaButton.setTitle(self.category, for: [])
        }
        let womenClothing = UIAction(title: "women's clothing") { action  in
            self.category = "women's clothing"
            self.categoriaButton.setTitle(self.category, for: [])
        }
        let menu = UIMenu(children: [electronics, jewelery, mensClothing, womenClothing])
        return menu
    }
    
    func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        showErrorAlert( title: titleAndMessage.0 , message: titleAndMessage.1)
    }
    
    func showSuccesAlert(msg: String){
        alert.title = "Bien hecho!"
        alert.message = msg
        present(alert, animated: true, completion: nil)
    }
    
    func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Asegúrate de estar conectado a internet. Inténtalo de nuevo."
        case .decodingError:
            title = "Decoding Error"
            message = "No pudimos procesar su solicitud. Inténtelo de nuevo."
        }
        return (title, message)
    }
    
    func showErrorAlert(title: String, message: String) {
       
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
    
    func okTapped() {
        dismissEditProductView()
    }
    
}

extension EditProductView: EditProductUI {
    func dismissEditProductView() {
        self.dismiss(animated: true)
    }
    
    
    
    func update() {
        //TODO: - Para creación de Nuevo Producto
    }
    
    func update(productToEdit: EditProductViewModel) {
        
        guard let url = URL(string: productToEdit.productImageUrl) else { return }
        getImage(url: url) { img in
            self.productImageView.image = img
        }
        self.category = productToEdit.productCategory.description
        categoriaButton.setTitle(category, for: [])
        nombreTextField.text = productToEdit.productName
        precioTextField.text = productToEdit.productPrice
        descripcionTextView.text = productToEdit.productDescription
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

extension EditProductView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        
        productImageView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Actions
extension EditProductView {
    @objc func saveTapped(sender: UIButton) {
        
        guard let imageData = productImageView.image!.jpegData(compressionQuality: 0.8)?.base64EncodedString() else { return}
        
        let productoEditado: EditProductViewModel = EditProductViewModel(productName: nombreTextField.text!, productDescription: descripcionTextView.text!, productCategory: category, productPrice: precioTextField.text!, productImageUrl: imageData)
        
        presenter.onTapSave(model: productoEditado)
    }
    
    @objc func cambiarImagenTapped(sender: UIButton){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
        alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
            
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
