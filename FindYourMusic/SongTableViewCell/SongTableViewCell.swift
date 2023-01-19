//
//  SongTableViewCell.swift
//  FindYourMusic
//
//  Created by Irakli Nozadze on 19.01.23.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet var trackName: String!
    @IBOutlet var artistName: String!
    @IBOutlet var artwork: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "SongTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SongTableViewCell", bundle: nil)
    }
    
    func configure(with songView: SongViewModel) {
        self.trackName = songView.trackName
        self.artistName = songView.artistName
        self.artwork = songView.artwork
        
    }
}
