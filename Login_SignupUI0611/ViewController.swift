//
//  ViewController.swift
//  Login_SignupUI0611
//
//  Created by Aniket Patil on 06/11/23.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate, DataPass {
    
    func dataPassing(email: String, confPass: String) {
        txtLoginEmail.text = email
        txtLoginPass.text = confPass
    }
    

    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var txtLoginEmail: UITextField!
    
    @IBOutlet weak var txtLoginPass: UITextField!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    var iconClick = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtFiledIcon() //User Icon in Email field
        PassToggle()  //Eye Iocon
        self.hideKeyboardTappedAround() //hide keyboard function
        CornerRadius() //Corner Radius
        
        txtLoginEmail.delegate = self //Add border color after clicking
        txtLoginPass.delegate = self  //Add border color after clicking
        
        //add padding to textfield
        self.txtLoginEmail.addPaddingTxt()
        self.txtLoginPass.addPaddingTxt()
        
        //Enable and disable scroll view
        if UIDevice.current.hasNotch {
            ScrollView.isScrollEnabled = false
        }
        else
        {
            ScrollView.isScrollEnabled = true

        }
        
        
    
    }
    
    
    @IBAction func LocationBtn(_ sender: UIButton) {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(locationVC, animated: true)
        
    }
    
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        
        if txtLoginEmail.text!.isEmpty
        {
            showToast(controller: self, message: "Please Enter Mail", seconds: 2)
            txtLoginEmail.layer.borderColor = UIColor.red.cgColor
            
        }
        
        else if txtLoginPass.text!.isEmpty
        {
            showToast(controller: self, message: "Please Enter Password", seconds: 2)
            txtLoginPass.layer.borderColor = UIColor.red.cgColor


        }
        
        else
        {
//            showToast(controller: self, message: "Successfully Login", seconds: 2)
            let loginvc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            self.navigationController?.pushViewController(loginvc, animated: true)
        }
        
        
        
    }
    
    @IBAction func SignupBtn(_ sender: UIButton) {
        
        let SignUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        SignUpVc.delegate = self
        self.navigationController?.pushViewController(SignUpVc, animated: true)
        
    }
    
    
    //Code for User icon in textfiled
    
    
    func TxtFiledIcon()
    {
        let UserIcon = UIImageView()
        UserIcon.image = UIImage(named: "user")
        let contentView = UIView() //For blank space
        contentView.addSubview(UserIcon)
        
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "user")!.size.width, height: UIImage(named: "user")!.size.height)
        UserIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "user")!.size.width, height: UIImage(named: "user")!.size.height)
        
        txtLoginEmail.rightView = contentView
        txtLoginEmail.rightViewMode = .always
        txtLoginEmail.clearButtonMode = .whileEditing

        
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
        
        
        txtLoginPass.rightView = contentView
        txtLoginPass.rightViewMode = .always
        txtLoginPass.clearButtonMode = .whileEditing

        
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
            txtLoginPass.isSecureTextEntry = false
        }
        
        else
        {
            iconClick = true
            tappedImage.image = UIImage(named: "close")
            txtLoginPass.isSecureTextEntry = true
        }
    }
    
    //Code for Eye icon for password hide and show ---End
    
    
    //Code for add border color after selecting--Start
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField != txtLoginEmail || textField != txtLoginPass {
            
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.blue.cgColor
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    //Code for add border color after selecting-- End
    
    
    //return keyboard-- Strat
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //return keyboard-- End
    
    
    //Function for alert message
    
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
    
    //Function for corner radius
    
    func CornerRadius()
    {
        txtLoginEmail.layer.borderWidth = 1
        txtLoginEmail.layer.cornerRadius = 25
        
        txtLoginPass.layer.borderWidth = 1
        txtLoginPass.layer.cornerRadius=25
    }
    
}
