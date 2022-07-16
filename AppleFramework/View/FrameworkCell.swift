//
//  FrameworkCell.swift
//  AppleFramework
//
//  Created by 권유진 on 2022/07/13.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImgae: UIImageView!
      
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
    }
      
      func configure(_ framework: AppleFramework) {
          thumbnailImgae.image = UIImage(named: framework.imageName)
          
          nameLabel.text = framework.name
      }
    
}
