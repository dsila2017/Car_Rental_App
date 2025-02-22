//
//  SignUpViewController.swift
//  Car_Rental_App
//
//  Created by David on 2/21/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Register to get started"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var signUpButton: CustomButton = {
        let button = CustomButton(name: "Sign Up", style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector (handleSignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: CustomButton = {
        let button = CustomButton(name: "Cancel", style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector (cancelSignUp), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.viewModel = SignUpViewModel()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
    }
    
    @objc func handleSignUp() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showError("Please fill in all fields.")
            return
        }
        
        viewModel.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                
                print("Registration successful!")
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(let error):
                
                self.showError(error.localizedDescription)
            }
        }
    }
    
    @objc func cancelSignUp() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        title = "Welcome!"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
    }
    
    private func setupUI() {
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.addSubview(welcomeLabel)
        topView.addSubview(logoImageView)
        topView.addSubview(emailTextField)
        topView.addSubview(passwordTextField)
        
        topView.addSubview(textFieldsStackView)
        
        bottomView.addSubview(signUpButton)
        bottomView.addSubview(cancelButton)
        
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
            
            welcomeLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            //welcomeLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            //welcomeLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.4),
            //welcomeLabel.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.05),
            
            logoImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            textFieldsStackView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            textFieldsStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            textFieldsStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            textFieldsStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -40),
            
            signUpButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            cancelButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
            
        ])
    }
    
}
