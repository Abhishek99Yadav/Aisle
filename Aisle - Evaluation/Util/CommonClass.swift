//
//  CommonClass.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 22/08/23.
//
//import UIKit
//
//class CommonClass {
//    static let shared = CommonClass()
//
//    func setAttributedText(text: String, fontName: String, fontSize: CGFloat, lineHeight: CGFloat) -> NSMutableAttributedString? {
//        let font = UIFont(name: fontName, size: fontSize)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: font!,
//            .foregroundColor: UIColor.black
//        ]
//        let attributedText = NSAttributedString(string: text, attributes: attributes)
//
//        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineHeight - font!.lineHeight // Adjust as needed
//        mutableAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedText.length))
//
//        return mutableAttributedText
//    }
//    func addPopUpAlert() {
//        // Show a popup indicating the error
//        let alertController = UIAlertController(
//            title: "Invalid Phone Number",
//            message: "Please enter a 10-digit phone number.",
//            preferredStyle: .alert
//        )
//        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okayAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}
import UIKit

class CommonClass {
    static let shared = CommonClass()

    private init() {}

    func setAttributedText(text: String, fontName: String, fontSize: CGFloat, lineHeight: CGFloat) -> NSMutableAttributedString? {
        guard let font = UIFont(name: fontName, size: fontSize) else {
            return nil
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]

        let attributedText = NSAttributedString(string: text, attributes: attributes)

        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - font.lineHeight // Adjust as needed
        mutableAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedText.length))

        return mutableAttributedText
    }

    func addPopUpAlert(from viewController: UIViewController?, message: String?, title: String?) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okayAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }

    // Convert hexadecimal color to UIColor
    func colorWithHexString(hexString: String) -> UIColor {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    func getImageFromURL(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Error creating image from data")
                completion(nil)
            }
        }.resume()
    }

    func getImage(url: String?, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = URL(string: url ?? "") {
            getImageFromURL(imageUrl) { image in
                completion(image)
            }
        } else {
            print("Invalid Image URL")
            completion(nil)
        }
    }
}
