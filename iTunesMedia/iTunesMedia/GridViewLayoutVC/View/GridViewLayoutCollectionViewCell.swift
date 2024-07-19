//
//  GridViewLayoutCollectionViewCell.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class GridViewLayoutCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCellData(_  ituneDetail : resultsDataModel){
        lblTitle.text = ituneDetail.trackName
        
        
        ImageConverter.imageconvert(imageUrl: ituneDetail.artworkUrl60 ?? "") { [weak self] image in
            
            DispatchQueue.main.async {
                self?.img.image = image
            }
        }
        
    }
    
}
