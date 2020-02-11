//
//  ViewController.swift
//  BatmanApp
//
//  Created by Pedro Vargas on 09/02/20.
//  Copyright © 2020 Pedro Vargas. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CallForHelp(_ sender: Any) {
        
        if Model.shared.selectedNumber == nil {
            showContactView()
            
        } else {
            
            if let url = URL(string: "tel://\(Model.shared.selectedNumber!)") {
                
                UIApplication.shared.open(url)
                
            } else {
                print("deu ruim")
            }
        }
    }
    
    @IBAction func addContact(_ sender: Any) {
        showContactView()
    }
    
    func showContactView() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        if contact.phoneNumbers.count != 0 {
            print(contact.givenName)
            
            print(contact.phoneNumbers[0].value.stringValue)
           
            var numberReplaced = contact.phoneNumbers[0].value.stringValue.replacingOccurrences(of: "+", with: "")
            
            numberReplaced = numberReplaced.replacingOccurrences(of: "(", with: "")
            numberReplaced = numberReplaced.replacingOccurrences(of: ")", with: "")
            numberReplaced = numberReplaced.replacingOccurrences(of: " ", with: "")
            numberReplaced = numberReplaced.replacingOccurrences(of: "-", with: "")
            if numberReplaced.first == "5" && Array(numberReplaced)[1] == "5" {
                numberReplaced.removeFirst()
                numberReplaced.removeFirst()
            }

            
            print(numberReplaced)
            
            Model.shared.selectedNumber = numberReplaced
        } else {
            dismiss(animated: false, completion: nil)
        }
        
        
    }
    
    
    
}

