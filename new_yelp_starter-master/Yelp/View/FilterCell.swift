//
//  FilterCell.swift
//  Yelp
//
//  Created by FunTap on 6/19/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
protocol FilterCellDelegate {
    func filterCell(filterCell: FilterCell, didChangeValue value: Bool)
}

class FilterCell: UITableViewCell {

    @IBOutlet weak var filerSwitch: UISwitch!
    @IBOutlet weak var FilterLable: UILabel!
    
    var delegate: FilterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filerSwitch.addTarget(self, action: #selector(FilterCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        delegate?.filterCell(filterCell: self, didChangeValue: filerSwitch.isOn)
    }

}
