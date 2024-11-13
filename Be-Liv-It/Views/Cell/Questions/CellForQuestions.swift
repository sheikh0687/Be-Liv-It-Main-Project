//
//  CellForQuestions.swift
//  Be-Liv-It
//
//  Created by mac on 10/01/23.
//

import UIKit

class CellForQuestions: UICollectionViewCell {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var textViewOt: UIView!
    @IBOutlet var btnImageOutlet: UIButton!
    @IBOutlet var textAnswerOt: UITextField!
    var onImageTappedButton: (() -> Void)? = nil
    var isEmptyTextFields: Bool {
        return textAnswerOt.text!.isEmpty
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textViewOt.layer.borderWidth = 0.5
        self.textViewOt.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnImageTapped(_ sender: UIButton) {
        onImageTappedButton?()
    }
}

