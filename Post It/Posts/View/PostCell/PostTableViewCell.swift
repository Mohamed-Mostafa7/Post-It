//
//  PostTableViewCell.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import UIKit

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
    
    func configureCell() {
        postImageView.image = UIImage(systemName: "photo.fill")
        postTitle.text = "title"
    }
    
}
