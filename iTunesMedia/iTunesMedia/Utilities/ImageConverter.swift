//
//  ImageConverter.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import Foundation
import UIKit
import AVKit

class ImageConverter{
        
   static func imageconvert(imageUrl: String , completion: @escaping (_ image: UIImage ) -> Void){
        let pictureURL = URL(string: imageUrl)!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: pictureURL) { (data, response, error) in
            if let e = error {
                print("Error downloading  picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        
                        completion((image ?? UIImage(systemName: "PlaceHolder"))!)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
       downloadPicTask.resume()
    }
    
    static func loadThumbnail(imageUrl: String,  completion: @escaping ((_ image: UIImage) -> Void)){
        DispatchQueue.global().async {
            let url = URL(string: imageUrl)!
            let imgAsset = AVAsset(url: url)
            let avAssetImgGenerator = AVAssetImageGenerator(asset: imgAsset)
            avAssetImgGenerator.appliesPreferredTrackTransform = true
            
            
            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
            
            do{
                let cgThumbImage = try avAssetImgGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImg = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbImg)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
}
