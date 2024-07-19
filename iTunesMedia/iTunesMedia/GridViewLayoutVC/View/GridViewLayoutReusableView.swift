//
//  GridViewLayoutReusableView.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit

class GridViewLayoutReusableView: UICollectionReusableView {
   
    static let identifier =  "GridViewLayoutReusableView"
        
    public func setUp(_ keyStrings: String){
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        header.backgroundColor = .gray
        
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: header.frame.size.width, height: header.frame.size.height))
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = keyStrings
        header.addSubview(label)
       addSubview(header)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        label.frame = bounds
    }
}
