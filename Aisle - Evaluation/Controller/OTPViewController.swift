//
//  OTPViewController.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 23/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var enterLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var backVw: UIView!
    let maxLength = 4
    var phNo: String = ""
    var timer: Timer?
        var secondsRemaining = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let otp = otpTextField.text, !otp.isEmpty else {
            CommonClass.shared.addPopUpAlert(from: self, message: "Please enter OTP.", title: "Missing OTP")
            return
        }
        
        verifyOTP(with: otp)
    }
}
// MARK: - API Call
extension OTPViewController {
    func verifyOTP(with otp: String) {
        let baseUrl = StringConstants.baseURL
        let endpoint = "/users/verify_otp"
        
        guard let url = URL(string: baseUrl + endpoint) else {
            print("Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let number = UserDefaults.standard.string(forKey: "phoneNumber") else {
                    print("Number not found in UserDefaults.")
                    return
                }
        let parameters: [String: Any] = [
            "number": "+91\(phNo)",// "number": "\(number)",
            "otp": "\(otp)"
        ]
        print(parameters)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data:", error.localizedDescription)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API Request Failed with error:", error.localizedDescription)
                return
            }

            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let authToken = json?["token"] as? String {
                        UserDefaults.standard.set(authToken, forKey: "authToken")
                        print("Received Auth Token:", authToken)
//                        self.moveToNotesScreen()
                        self.moveToTabBarController()
                    } else {
                        DispatchQueue.main.async {
                            CommonClass.shared.addPopUpAlert(from: self, message: "INCORRECT OTP", title: "Failure")
                        }
                        print("Auth Token not found in API response.")
                    }
                } catch {
                    print("Error parsing JSON:", error.localizedDescription)
                }
            }
        }.resume()
    }
}
//MARK: - Initial UI Config
extension OTPViewController {
    
    func initialConfig() {
        updateTimerLabel()
        
        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        phNo = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
        self.setColor()
        //        self.setFont()
        self.setText()
        self.otpTextField.delegate = self
        self.otpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func setColor() {
        self.backVw?.backgroundColor = .white
        self.phoneNumberLbl?.textColor = .black
        self.enterLbl?.textColor = .black
        self.otpLbl?.textColor = .black
        //        self.countryCodeLbl.textColor = .black
        self.otpTextField?.textColor = .black
        self.contBtn?.backgroundColor = UIColor(red: 249/255, green: 203/255, blue: 16/255, alpha: 1.0)
        
        self.contBtn?.titleLabel?.textColor = .black
    }
    func setText() {
        self.phoneNumberLbl?.text = "+91 \(self.phNo)"
        self.enterLbl.text = StringConstants.enterOTP
        self.otpLbl.text = StringConstants.OTP
        self.contBtn.titleLabel?.text = StringConstants.continueBtnLbl
    }
    //    func setFont() {
    //
    //    }
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
        }
    }
    
    func updateTimerLabel() {
        DispatchQueue.main.async { [self] in
            let minutes = self.secondsRemaining / 60
            let seconds = self.secondsRemaining % 60
            timerLbl.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    func moveToNotesScreen() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let notesViewController = storyboard.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController {
                self.navigationController?.pushViewController(notesViewController, animated: true)
            }
        }
    }
//    func moveToTabBarController() {
//        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerIdentifier") as? CustomTabBarController {
//                UIApplication.shared.windows.first?.rootViewController = tabBarController
//            }
//        }
//    }
    func moveToTabBarController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = tabBarController
                }
            }
        }
    }
}
extension OTPViewController: UITextFieldDelegate {
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
