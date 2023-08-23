//
//  PhoneNumberViewController.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 22/08/23.
//

import UIKit

class PhoneNumberViewController: ParentViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var getOtpLbl: UILabel!
    @IBOutlet weak var backgroundVw: UIView!
    let maxLength = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
        if let phoneNumber = phoneNumberTextField.text, phoneNumber.count == 10 {
            makePhoneNumberAPICall(phoneNumber: phoneNumber)
        } else {
            CommonClass.shared.addPopUpAlert(from: self, message: "Please enter a 10-digit phone number.", title: "Invalid Phone Number")
        }
            }
    }
extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= maxLength
        }
        @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text, text.count > maxLength {
                let index = text.index(text.startIndex, offsetBy: maxLength)
                textField.text = String(text[..<index])
            }
            if textField.text?.count == maxLength {
                    textField.resignFirstResponder()
                }
        }
}
//MARK: - Initial UI Config
extension PhoneNumberViewController {

    func initialConfig() {
        self.setColor()
//        self.setFont()
        self.setText()
        self.phoneNumberTextField.delegate = self
        self.phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func setColor() {
        self.backgroundVw.backgroundColor = .white
        self.getOtpLbl.textColor = .black
        self.titleLbl.textColor = .black
        self.countryCodeLbl.textColor = .black
        self.phoneNumberTextField.textColor = .black
        self.continueBtn.backgroundColor = UIColor(red: 249/255, green: 203/255, blue: 16/255, alpha: 1.0)

        self.continueBtn.titleLabel?.textColor = .black
    }
    func setText() {
        self.getOtpLbl.text = StringConstants.getOTP
        self.titleLbl.text = StringConstants.enterPhoneNumber
        self.continueBtn.titleLabel?.text = StringConstants.continueBtnLbl
        self.countryCodeLbl.text = StringConstants.countryCodeIn
    }
//    func setFont() {
//        
//    }
    func moveToOTPScreen() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let otpViewController = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
                self.navigationController?.pushViewController(otpViewController, animated: true)
            }
        }
    }
}
//MARK: - API Call
extension PhoneNumberViewController {
    func makePhoneNumberAPICall(phoneNumber: String) {
        let country_code = "+91"
        let baseURL = StringConstants.baseURL
        let endpoint = "/users/phone_number_login"
        
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        let parameters: [String: Any] = [
            "number": "\(country_code)\(phoneNumber)"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data:", error.localizedDescription)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("An error occurred:", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response:", responseString)
                
                if responseString.contains("false") {
                    DispatchQueue.main.async {
                        CommonClass.shared.addPopUpAlert(from: self, message: "Phone number verification failed. Please try again.", title: "Failure")
                    }
                } else if responseString.contains("true") {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                        self.moveToOTPScreen()
                    }
                } else {
                    print("Err")
                    DispatchQueue.main.async {
                        CommonClass.shared.addPopUpAlert(from: self, message: "Phone number verification failed. Please try again.", title: "Failure")
                    }
                }
            } else {
                print("Invalid response data")
            }
        }.resume()
    }
}
