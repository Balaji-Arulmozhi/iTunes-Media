//
//  MediaTableViewCell.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var mediaLabel: UILabel!
    var select = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func updateUI(_ selectedList: [String] , title: String){
//        if selectedList.contains(title){
//            imgeView.isHidden = true
//            imgeView.image = UIImage(named: "tick")
//        }else{
//            imgeView.isHidden = false
//        }
//    }
}
