//
//  CustomTabBarController.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 23/08/23.
//

import UIKit
protocol DataUpdateDelegate: AnyObject {
    func updateData(data: [Profile])
}
class CustomTabBarController: UITabBarController {weak var dataUpdateDelegate: DataUpdateDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Gilroy-Bold", size: 12)!,
            .foregroundColor: CommonClass.shared.colorWithHexString(hexString: "#9B9B9B"),
            .kern: 0,
            .baselineOffset: 0
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        self.fetchTestProfileList()
        selectedIndex = 1
    }
}
extension CustomTabBarController {
    func fetchTestProfileList() {
        guard let authToken = UserDefaults.standard.string(forKey: "authToken") else {
            print("Auth token not found.")
            return
        }
        
        let baseURL = "https://app.aisle.co/V1"
        let endpoint = "/users/test_profile_list"
        
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API Request Failed with error:", error.localizedDescription)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Root.self, from: data)
                    print(decodedData)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    func setViewControllers() {
        let firstViewController = UIViewController()
        let secondViewController = NotesViewController()
        let thirdViewController = UIViewController()
        let forthViewController = UIViewController()
        
        let viewControllers = [firstViewController, secondViewController, thirdViewController,forthViewController]
        
        self.setViewControllers(viewControllers, animated: false)
    }
}
