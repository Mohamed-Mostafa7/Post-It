//
//  PostTableViewCell.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    static var identifier = "PostTableViewCell"

    @IBOutlet weak var CellCustomView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configureCell(title: String, ImageURL: String) {
        postImageView.image = UIImage(systemName: "photo.fill")
        postTitle.text = title
        getImage(urlString: ImageURL)
    }
    
    func getImage(urlString: String) {
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: postImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        postImageView.kf.indicatorType = .activity
        postImageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
