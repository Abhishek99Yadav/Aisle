//
//  NotesViewController.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 23/08/23.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var firstNameAge: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    var dataModel: [Profile] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    func getData() {
        if let encodedData = UserDefaults.standard.data(forKey: "profileData") {
            let decoder = JSONDecoder()
            if let profiles = try? decoder.decode([Profile].self, from: encodedData) {
                self.dataModel = profiles
                print(profiles)
            }
        }
        
    }
}
extension NotesViewController: DataUpdateDelegate {
    func updateData(data: [Profile]) {
        self.dataModel = data
        self.initialConfig()
    }
}
extension NotesViewController {
    func initialConfig() {
        setText()
        setImage()
    }
    func setText() {
        DispatchQueue.main.async {
            self.firstNameAge.text = "\(String(describing: self.dataModel.first?.firstName)), \(String("25"))"
        }
    }
    func setImage() {
        
    }
}
