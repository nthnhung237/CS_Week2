//
//  FilterDealCell.swift
//  Yelp
//
//  Created by FunTap on 6/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterDealCellDelegate {
    func filterDealCell(filterDealCell: FilterDealCell, didChangeValue value: Bool)
}

class FilterDealCell: UITableViewCell {

    @IBOutlet weak var DealSwitch: UISwitch!
    @IBOutlet weak var lbDeal: UILabel!
    
    var delegate: FilterDealCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DealSwitch.addTarget(self, action: #selector(FilterCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        delegate?.filterDealCell(filterDealCell: self, didChangeValue: DealSwitch.isOn)
    }

}
