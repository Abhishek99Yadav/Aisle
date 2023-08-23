//
//  InspectableView.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 22/08/23.
//

import UIKit

@IBDesignable
class InspectableView: UIView {
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
    }
}

