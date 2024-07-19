//
//  MediaDetailsViewController.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/18/24.
//

import UIKit
import AVKit
import AVFoundation

class MediaDetailsViewController: UIViewController {
    
    @IBOutlet weak var previewThumbnail: UIImageView!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenrename: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var mediaDetails: resultsDataModel?
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIData()
        // Do any additional setup after loading the view.
    }
    
//  Will show preview
    @IBAction func previewAction(_ sender: Any) {
        if let url = URL(string: mediaDetails?.trackViewUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
//    Play the Preview Video
    @IBAction func playAction(_ sender: Any) {
        let url = URL(string: mediaDetails?.previewUrl ?? "")!
        playerView =  AVPlayer(url: url as URL)
        playerViewController.player = playerView
        self.present(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
        
    }
    
    
    func updateUIData(){
        lblArtistName.text = mediaDetails?.artistName
        lblTrackName.text = mediaDetails?.trackName
        lblGenrename.text = mediaDetails?.primaryGenreName
        lblDescription.text = mediaDetails?.longDescription
        
        if let artworkUrl100 = mediaDetails?.artworkUrl100{
            ImageConverter.imageconvert(imageUrl: artworkUrl100) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imgView.image = image
                }
            }
        }
        
        
        if let previewUrl = mediaDetails?.previewUrl{
            ImageConverter.loadThumbnail(imageUrl: previewUrl) { [weak self] image in
                self?.previewThumbnail.image = image
            }
        }
    }
}

