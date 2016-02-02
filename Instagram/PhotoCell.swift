//
//  PhotoCell.swift
//  Instagram
//
//  Created by Rian Walker on 1/31/16.
//  Copyright © 2016 Rian Walker. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
