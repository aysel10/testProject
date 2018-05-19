//
//  AuthorizationViewController.swift
//  TestProject
//
//  Created by Ayselkas on 5/19/18.
//  Copyright © 2018 IceL. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    let pref = UserDefaults.standard
    let appId = "010eb1f970540e858b396cd314b21729"
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var authLabel: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @IBAction func showWeatherAlert(_ sender: Any) {
        request()
    }
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField{
            let email = emailTextField.text
            if isValidEmail(email: email){
                emailTextField.errorMessage = ""
            }else{
                emailTextField.errorMessage = "Not valid email"
            }
        }
        if textField == passwordTextField{
            let password = passwordTextField.text
            if isValidPassword(testStr: password){
                passwordTextField.errorMessage = ""
                
            }else{
                passwordTextField.errorMessage = "Not valid password"
            }
        }
        return true
    }

    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
    
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
  
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @IBAction func alertShow(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
    func request(){
        
        let parameters : [String : String] = [
            "q" : "Moscow",
            "units" : "metric",
            "appid" : "010eb1f970540e858b396cd314b21729"
        ]
        Alamofire.request("http://api.openweathermap.org/data/2.5/find",method: .get,parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess{
                print("success")
                let json  = JSON(response.result.value!)
                print(json)
                let array = json["list"].arrayValue
                for item in array {
                    let mainArray = item["main"]
             
                    let temp = mainArray["temp"].stringValue
                    let tempMin = mainArray["temp_min"].intValue
                    let tempMax = mainArray["temp_max"].intValue
                        
                    let name = item["name"].stringValue
                   
                    self.pref.set(tempMin, forKey: "tempMin")
                    self.pref.set(name,forKey: "name")
                    self.pref.set(tempMax,forKey: "tempMax")
                    self.pref.set(temp,forKey:"temp")

            }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
