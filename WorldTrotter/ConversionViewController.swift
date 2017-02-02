//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Keagan Sweeney on 1/18/17.
//  Copyright © 2017 Keagan Sweeney. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    override func viewWillAppear(_ animated: Bool) {
        if hour < 13{
            self.view.backgroundColor = UIColor.cyan
        } else {
            self.view.backgroundColor = UIColor.blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Conversion did load!")
        print(hour)
        updateCelsiusLabel()
    }
    
    // MARK: Outlets
    @IBOutlet var celsiusLable: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLable.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLable.text = "???"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // MARK: Actions
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
       
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        let letters = NSCharacterSet.letters
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil{
            return false
        } else if string.rangeOfCharacter(from: letters) != nil{
            
            return false;
            
        } else {
            return true
        }
    }
    
    
}
