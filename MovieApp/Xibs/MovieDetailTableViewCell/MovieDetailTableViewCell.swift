//
//  MovieDetailTableViewCell.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 30/07/2023.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieTagLine: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieORelease: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
