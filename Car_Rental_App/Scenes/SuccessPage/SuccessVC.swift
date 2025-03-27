import UIKit

class SuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let successImageView = UIImageView()
        successImageView.image = UIImage(systemName: "checkmark.circle.fill")
        successImageView.tintColor = .green
        successImageView.contentMode = .scaleAspectFit
        successImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successImageView)
        
        let successLabel = UILabel()
        successLabel.text = "Transaction Successful"
        successLabel.font = UIFont.boldSystemFont(ofSize: 24)
        successLabel.textColor = .green
        successLabel.textAlignment = .center
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successLabel)
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.tintColor = .black
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            successImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            successImageView.widthAnchor.constraint(equalToConstant: 100),
            successImageView.heightAnchor.constraint(equalToConstant: 100),
            
            successLabel.topAnchor.constraint(equalTo: successImageView.bottomAnchor, constant: 20),
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 30),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func closeButtonTapped() {
        if let navigationController = navigationController {
            // Look for ProductsViewController in the navigation stack
            if let targetVC = navigationController.viewControllers.first(where: { $0 is ProductsViewController }) {
                navigationController.isNavigationBarHidden = true
                navigationController.popToViewController(targetVC, animated: true)
            } else {
                // Fallback: Pop to root if ProductsViewController isn't found
                navigationController.isNavigationBarHidden = true
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
}
