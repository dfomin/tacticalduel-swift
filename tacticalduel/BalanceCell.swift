//
//  BalanceCell.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 20/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import UIKit

class BalanceCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        GameBalance.shared[key.text!] = Int(value.text!)!
        
        return true
    }
}
