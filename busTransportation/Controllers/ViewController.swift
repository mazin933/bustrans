//
//  ViewController.swift
//  busTransportation
//
//  Created by Mazin Musallam on 10/20/17.
//  Copyright © 2017 bus. All rights reserved.
//

import UIKit
import Toaster
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let type = ["Student", "Driver"]
    
    let picker = UIPickerView()
    
    var loginM = loginModel()
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var typeTF: UITextField!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        if(loginM.checkTextFieldsValues(usernameTF, passwordTF, typeTF)) {
            Toast(text: "Please fill in all the fields", duration: Delay.short).show()
        } else {
            
            let parameters: [String : Any]? = [
                "username": usernameTF!.text!,
                "password": passwordTF!.text!,
                "type": typeTF!.text!
            ]
            if(typeTF!.text! == "Student"){
            Alamofire.request("https://bus-transportation-server.herokuapp.com/students", method: .post, parameters: parameters!, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    self.performSegue(withIdentifier: "currentLocation", sender: self)
                    print(value)
                case .failure:
                    Toast(text: "Username or password is wrong", duration: Delay.short).show()
                }
            }
         
            } else {
                Alamofire.request("https://bus-transportation-server.herokuapp.com/busDriver", method: .post, parameters: parameters!, encoding: JSONEncoding.default).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        self.performSegue(withIdentifier: "currentLocation", sender: self)
                        print(value)
                    case .failure:
                        Toast(text: "Username or password is wrong", duration: Delay.short).show()
                    }
                }
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        picker.dataSource = self
        
        typeTF.inputView = picker
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTF.text = type[row]
        self.view.endEditing(false)
    }
    

}

