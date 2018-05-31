//
//  MovieCell.swift
//  Movies
//
//  Created by Vasileios Loumanis on 31/05/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }
}
