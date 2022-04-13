import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
        
    @IBOutlet weak var passwordTextField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScroll))
        view.addGestureRecognizer(tabGesture)
        view.isUserInteractionEnabled = true
        
    }
    
    @objc func keybordWillShow (notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }

    @objc func keybordWillHide (notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func didTapOnScroll() {
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       
        
        let result = checkUserCredentials()
        if !result {
            showResalt()
        }
        
        return result
    }
    
    func checkUserCredentials() -> Bool {
       return loginTextField.text == "" && passwordTextField.text == ""
    }
    
    func showResalt() {
        let alert = UIAlertController(title: "Error", message: "Wrong login or password.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
