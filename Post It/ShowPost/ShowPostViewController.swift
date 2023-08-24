//
//  ShowPostViewController.swift
//  Post It
//
//  Created by Mohamed Mostafa on 24/08/2023.
//

import UIKit
import Kingfisher

class ShowPostViewController: UIViewController {
    
    var post: Post?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var PostTitle: UITextField!
    @IBOutlet weak var PostmessageTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureUI()
    }
    
    func ConfigureUI() {
        getImage(urlString: post?.imageURL ?? "")
        PostTitle.text = post?.title
        PostmessageTextView.text = post?.message
    }
    
    @IBAction func UpdateButtonTaped(_ sender: UIButton) {
    }
    
    @IBAction func DeleteButtonTapped(_ sender: UIButton) {
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
