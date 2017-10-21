//
//  loginModel.swift
//  busTransportation
//
//  Created by Mazin Musallam on 10/20/17.
//  Copyright © 2017 bus. All rights reserved.
//

import Foundation
import UIKit

class loginModel: UIViewController {
    
    func checkTextFieldsValues(_ textField: UITextField...) -> Bool {
        for tf in textField {
            if (tf.text?.isEmpty)! {
                return true
            }
        }
        return false
    }
    
}
