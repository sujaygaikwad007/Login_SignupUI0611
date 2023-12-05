//
//  SignupViewController.swift
//  Login_SignupUI0611
//
//  Created by Aniket Patil on 06/11/23.
//

import UIKit
protocol DataPass {
    func dataPassing(email:String,confPass:String)
}


class SignupViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var txtSignupUser: UITextField!
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var txtSignupConfirmPassword: UITextField!
    @IBOutlet weak var WarningMsg: UILabel!
    
    var iconClick = false
    
    
    var delegate:DataPass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        WarningMsg.isHidden = true
        CornerRadius()
        TxtUserFiledIcon() // Icon for User
        TxtEmailFiledIcon() //User Icon in Email field
        PassToggle()
        
        self.hideKeyboardTappedAround() //hide keyboard function

        
        //passed delegate for textfield highlight
        txtSignupUser.delegate = self
        txtSignupEmail.delegate = self
        txtSignupPassword.delegate = self
        txtSignupConfirmPassword.delegate = self
        
        //add padding to textfield
        self.txtSignupUser.addPaddingTxt()
        self.txtSignupEmail.addPaddingTxt()
        self.txtSignupPassword.addPaddingTxt()
        self.txtSignupConfirmPassword.addPaddingTxt()
        
        //Enable and disable scroll view
        if UIDevice.current.hasNotch {
            ScrollView.isScrollEnabled = false
        }
        else
        {
        ScrollView.isScrollEnabled = true

        }
        
        
            
    }
    
    
    
    @IBAction func CreateAccBtn(_ sender: UIButton) {
        
        if txtSignupUser.text!.isEmpty
        {
            //showToast(controller: self, message: "Please Enter User Name", seconds: 2)
            self.showAlertToast(message: "Please Enter User Name", font: .systemFont(ofSize: 12.0))
            txtSignupUser.layer.borderColor = UIColor.red.cgColor
            
        }
        else if txtSignupEmail.text!.isEmpty
        {
            showToast(controller: self, message: "Please Enter Email", seconds: 2)
            txtSignupEmail.layer.borderColor = UIColor.red.cgColor
            
            
        }
        else if !(txtSignupEmail.text?.isEmailValid)!
        {
            showToast(controller: self, message: "Please Enter a valid email", seconds: 2)
            txtSignupEmail.layer.borderColor = UIColor.red.cgColor
        }
        else if txtSignupPassword.text!.isEmpty
        {
            showToast(controller: self, message: "Password field should not be empty", seconds: 2)
            txtSignupPassword.layer.borderColor = UIColor.red.cgColor
            
        }
        else if !(txtSignupPassword.text?.isPasswordValid)!
        {
            showToast(controller: self, message: "Please Enter a valid password", seconds: 2)
            txtSignupPassword.layer.borderColor = UIColor.red.cgColor
        }
        else if txtSignupConfirmPassword.text!.isEmpty
        {
            showToast(controller: self, message: "Password field should not be empty", seconds: 2)
            txtSignupConfirmPassword.layer.borderColor = UIColor.red.cgColor
            
            
        }
        else if txtSignupPassword.text != txtSignupConfirmPassword.text
        {
            showToast(controller: self, message: "Passwords do not match", seconds: 2)
            txtSignupConfirmPassword.layer.borderColor = UIColor.red.cgColor
        }
        else
        {
            delegate.dataPassing(email: txtSignupEmail.text!, confPass: txtSignupConfirmPassword.text!)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        
    }
    
    @IBAction func SignUptoLogin(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    //Function for corner radius
    
    func CornerRadius()
    {
        txtSignupUser.layer.borderWidth = 1
        txtSignupUser.layer.cornerRadius = 25
        
        txtSignupEmail.layer.borderWidth = 1
        txtSignupEmail.layer.cornerRadius=25
        
        txtSignupPassword.layer.borderWidth = 1
        txtSignupPassword.layer.cornerRadius=25
        
        txtSignupConfirmPassword.layer.borderWidth = 1
        txtSignupConfirmPassword.layer.cornerRadius=25
    }
    
    //Code for add border color after selecting--Start
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField != txtSignupUser || textField != txtSignupEmail || textField != txtSignupPassword || textField != txtSignupConfirmPassword{
            
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.blue.cgColor

            
        }
        
        if textField == txtSignupPassword {
            WarningMsg.isHidden = false

        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        WarningMsg.isHidden = true
        
    }
    //Code for add border color after selecting-- End

    
    //Icon for User
    func TxtUserFiledIcon()
    {
        let UserIcon = UIImageView()
        UserIcon.image = UIImage(named: "user")
        let contentView = UIView() //For blank space
        contentView.addSubview(UserIcon)
        
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "user")!.size.width, height: UIImage(named: "user")!.size.height)
        UserIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "user")!.size.width, height: UIImage(named: "user")!.size.height)
        
        txtSignupUser.rightView = contentView
        txtSignupUser.rightViewMode = .always
        txtSignupEmail.clearButtonMode = .whileEditing
        
        
    }
    
    //Icon for Email
    func TxtEmailFiledIcon()
    {
        let UserIcon = UIImageView()
        UserIcon.image = UIImage(named: "email")
        let contentView = UIView() //For blank space
        contentView.addSubview(UserIcon)
        
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "email")!.size.width, height: UIImage(named: "email")!.size.height)
        UserIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "email")!.size.width, height: UIImage(named: "email")!.size.height)
        
        txtSignupEmail.rightView = contentView
        txtSignupEmail.rightViewMode = .always
        txtSignupEmail.clearButtonMode = .whileEditing
        
        
        
    }
    
    
    
    //Code for Eye icon for password hide and show ---Start
    
    func PassToggle()
    {
        let passIcon = UIImageView()
        passIcon.image = UIImage(named: "close")
        let contentView = UIView() //For blank space
        contentView.addSubview(passIcon)
        
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "close")!.size.width, height: UIImage(named: "close")!.size.height)
        
        
        passIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "close")!.size.width, height: UIImage(named: "close")!.size.height)
        
        
        txtSignupPassword.rightView = contentView
        txtSignupPassword.rightViewMode = .always
        txtSignupPassword.clearButtonMode = .whileEditing
        
        let tapGesture = UITapGestureRecognizer(target: self.self, action: #selector(imageTapped(tapGesture:)))
        
        passIcon.isUserInteractionEnabled = true
        passIcon.addGestureRecognizer(tapGesture)
    }
    
   
    
    @objc func imageTapped(tapGesture:UITapGestureRecognizer)
    {
        let tappedImage = tapGesture.view as! UIImageView
        
        if iconClick
        {
            iconClick = false
            tappedImage.image = UIImage(named: "open")
            txtSignupPassword.isSecureTextEntry = false
        }
        
        else
        {
            iconClick = true
            tappedImage.image = UIImage(named: "close")
            txtSignupPassword.isSecureTextEntry = true
        }
    }
    
    //Code for Eye icon for password hide and show ---End
    
    
    //Function for alert message -- Start
    
    func showToast(controller:UIViewController ,message:String,seconds:Double)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        let CancelBtn = UIAlertAction(title: "Close", style: .destructive)
        alert.addAction(CancelBtn)
        
        controller.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + seconds)
        {
            alert.dismiss(animated: true)
        }
    }
    //Function for alert message -- End

    
    
    //return keyboard-- Strat
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //return keyboard-- End
    
    
    

    

}


///------------------------------------------------------------------------------------------------

//Extension for the validation of textfields
extension String
{
    
    var isEmailValid: Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
        
    }
    
    var isPasswordValid:Bool{
        
        let passwordRegEx = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,12}")
        return passwordRegEx.evaluate(with: self)
    }
    
}

//extension for keyboard handling
extension UIViewController{
    func hideKeyboardTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

//extension for adding space in textfields.
extension UITextField{
    func addPaddingTxt(){
        let paddingView: UIView = UIView.init(frame:CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}

//Extension for devices has notch

extension UIDevice {
    var hasNotch:Bool{
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}


//Extension for alert toast

extension UIViewController{
    
    func showAlertToast(message:String,font:UIFont)
    {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y:50 , width: 150, height: 35))
        //Bottom y= self.view.frame.size.height - 100
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1, options: .curveEaseIn,animations: {
            toastLabel.alpha = 0.4
            
            
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}











