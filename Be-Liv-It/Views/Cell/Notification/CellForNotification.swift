//
//  CellForNotification.swift
//  Be-Liv-It
//
//  Created by mac on 12/01/23.
//

import UIKit

class CellForNotification: UITableViewCell {
    
    @IBOutlet var outletView: UIView!
    @IBOutlet var tittleLabel: UILabel!
    @IBOutlet var subTittleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.outletView.layer.borderWidth = 0.5
        self.outletView.layer.borderColor = UIColor.lightGray.cgColor
        self.outletView.layer.masksToBounds = true
        self.outletView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
