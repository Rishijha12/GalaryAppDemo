//  GallaryViewCell.swift
//  GalaryAppDemo
//  Created by Rishi Jha on 18/12/21.

import UIKit

class GallaryViewCell: UICollectionViewCell {
    //   MARK: ---------------------IBOUTLET------------------
    @IBOutlet weak var imgViewContainer: UIView!{
        didSet{
            
        }
    }
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
