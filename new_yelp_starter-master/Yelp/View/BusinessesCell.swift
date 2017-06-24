//
//  BusinessesCell.swift
//  Yelp
//
//  Created by FunTap on 6/19/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessesCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var businessLable: UILabel!
    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var reviewLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    
    var business: Business! {
        didSet {
            businessImage.setImageWith(business.imageURL!)
            businessLable.text = business.name
            addressLable.text = business.address
            distanceLable.text = business.distance
            reviewImage.setImageWith(business.ratingImageURL!)
            addressLable.text = business.address
            categoryLable.text = business.categories
            reviewLable.text = String(format: "%d Review",business.reviewCount!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        businessImage.layer.cornerRadius = 3
        businessImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
