//
//  ViewController.swift
//  Car_Rental_App
//
//  Created by David on 2/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        return topView
    }()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .red
        return bottomView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "car")
        return imageView
    }()
    
    lazy var loginItemsView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    lazy var loginItemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.backgroundColor = .yellow
        
        return stackView
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = .red
        textField.placeholder = "Email"
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .red
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var forgotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Button x"
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
        setupButton()
    }
    
    @objc func buttonTapped() {
        
        print(self)
    }
    
    
    private func setupButton() {
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.addSubview(logoImageView)
        topView.addSubview(loginItemsView)
        //topView.addSubview(forgotButton)
        
        loginItemsView.addSubview(loginItemsStackView)
        loginItemsView.addSubview(forgotButton)
        
        
        bottomView.addSubview(loginButton)
        
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            //logoImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            logoImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            logoImageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4),
            
            loginItemsView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            loginItemsView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            loginItemsView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            loginItemsView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            
            loginItemsStackView.centerXAnchor.constraint(equalTo: loginItemsView.centerXAnchor),
            loginItemsStackView.centerYAnchor.constraint(equalTo: loginItemsView.centerYAnchor),
            loginItemsStackView.leadingAnchor.constraint(equalTo: loginItemsView.leadingAnchor, constant: 20),
            loginItemsStackView.trailingAnchor.constraint(equalTo: loginItemsView.trailingAnchor, constant: -20),
            loginItemsStackView.heightAnchor.constraint(equalTo: loginItemsView.heightAnchor, multiplier: 0.5),
            
            forgotButton.topAnchor.constraint(equalTo: loginItemsStackView.bottomAnchor),
            forgotButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            
        ])
    }
}

import UIKit

class CustomTextField: UITextField {
    
    let padding: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
}

