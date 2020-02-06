//
//  ViewController.swift
//  Gigs
//
//  Created by FGT MAC on 2/5/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

enum LoginType: String{
    case signUp
    case signIn
}

import UIKit

class LoginViewController: UIViewController {
    
    
    //Will be use to recieve the gigController using prepare for segue
    var gigController: GigController?
    
    //using enum to difine current state which defaults to signUp
    var loginType = LoginType.signUp

    //MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Actions
    @IBAction func actionSegmentedButton(_ sender: UISegmentedControl) {
        //set properties base on user selection
        if sender.selectedSegmentIndex == 0 {//Sign up
            loginType = LoginType.signUp
            actionButton.titleLabel?.text = "Sign Up"
            
        }else{//Login
            loginType = LoginType.signIn
            actionButton.titleLabel?.text = "Sign In"
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        
        //Unwrap gigController
        guard let gigController = gigController else { return }
        
        //Unwrap text fields and check if they are empty
        guard let username = userNameTextField.text ,!username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {return}
            
        //creating user
        let user = User(username: username, password: password)
        
        //Sign Up
        if loginType == LoginType.signUp{
            gigController.signUp(for: user) { (error) in
                //Handle error
                if let error = error{
                   print("Error during Sign Up: \(error)")
                }else{
                    //create alert in main queue because this is related to UI
                    DispatchQueue.main.async {
                        
                        //1.create the alert
                        let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please Sign In", preferredStyle: .alert)
                        
                        //2.Create Action
                        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        
                        //3.add the action to the controller
                        alertController.addAction(alertAction)
                        
                        //4.Present the aler
                        self.present(alertController, animated: true)
                    }
                    
                }
                
            }
            
         //Sign In
            }else{
            gigController.signIn(for: user) { (error) in
                //Handle error
                
                //create alert
            }
            
            }
        
        
    }
    

}

