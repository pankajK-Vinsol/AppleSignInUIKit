
import UIKit

class ProfileViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "User identifier: "
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(UIView())
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SignInWithAppleManager.checkUserAuth { (authState) in
            switch authState {
            case .undefined:
                let controller = LoginViewController()
                controller.modalPresentationStyle = .fullScreen
                controller.delegate = self
                self.present(controller, animated: true, completion: nil)
            case .signedOut:
                let controller = LoginViewController()
                controller.modalPresentationStyle = .fullScreen
                controller.delegate = self
                self.present(controller, animated: true, completion: nil)
            case .signedIn:
                print("Already signed in")
            }
        }
    }
}

extension ProfileViewController: LoginViewControllerDelegate {
    func didFinishAuth() {
        label.text = "User identifier: \(String(describing: UserDefaults.standard.string(forKey: SignInWithAppleManager.userIdentifierKey)))"
    }
}
