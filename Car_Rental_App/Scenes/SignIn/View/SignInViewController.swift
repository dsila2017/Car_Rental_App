import UIKit

final class SignInViewController: UIViewController {
    
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
        imageView.image = UIImage(named: "Porsche")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var loginItemsView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var loginItemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldsStackView, forgotButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
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
    
    lazy var forgotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.title = "Forgot Password?"
        button.configuration?.baseForegroundColor = .black
        
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: CustomButton = {
        let button = CustomButton(name: "Log In", style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: CustomButton = {
        let button = CustomButton(name: "SignUp", style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(signUpButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: SignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = SignInViewModel()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showError("Please enter both email and password.")
            return
        }
        viewModel?.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.pushViewController(ProductsViewController(), animated: true)
                
            case .failure(let error):
                self?.showError("Login failed: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func resetButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return self.showError("Please Enter Email")
        }
        viewModel?.resetPassword(email: email, forgotCompletion: { [weak self] result in
                switch result {
                case .success:
                    self?.showError("Email sent successfully")
                case .failure(let error):
                    self?.showError("Error: \(error.localizedDescription)")
                }
            })
    }
    
    @objc func signUpButtonAction(_ sender: UIButton) {
        guard let senderTitle = sender.titleLabel!.text else { return }
        print(senderTitle)
        
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    private func setupNavigationBar() {
        title = "Welcome back!"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupUI() {
        
        setupNavigationBar()
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.addSubview(logoImageView)
        topView.addSubview(loginItemsView)
        
        loginItemsView.addSubview(loginItemsStackView)
        
        bottomView.addSubview(loginButton)
        bottomView.addSubview(signUpButton)
        
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
            logoImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4),

            loginItemsView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            loginItemsView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            loginItemsView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            loginItemsView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),

            loginItemsStackView.centerXAnchor.constraint(equalTo: loginItemsView.centerXAnchor),
            loginItemsStackView.centerYAnchor.constraint(equalTo: loginItemsView.centerYAnchor),
            loginItemsStackView.leadingAnchor.constraint(equalTo: loginItemsView.leadingAnchor, constant: 20),
            loginItemsStackView.trailingAnchor.constraint(equalTo: loginItemsView.trailingAnchor, constant: -20),
            loginItemsStackView.heightAnchor.constraint(equalTo: loginItemsView.heightAnchor, multiplier: 0.7),

            textFieldsStackView.heightAnchor.constraint(equalTo: loginItemsStackView.heightAnchor, multiplier: 0.8),

            loginButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signUpButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }




}

extension UIViewController {
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
