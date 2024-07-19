//
//  ListViewLayOutTableViewCell.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class ListViewLayOutTableViewCell: UITableViewCell {

    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(_  ituneDetail : resultsDataModel){
        
        lblTitle.text = ituneDetail.artistName
        lblSubTitle.text = ituneDetail.trackName
        ImageConverter.imageconvert(imageUrl: ituneDetail.artworkUrl60 ?? "") { [weak self] image in
            
            DispatchQueue.main.async {
                self?.imgeView.image = image
            }
        }
        
        
    }
    
}
