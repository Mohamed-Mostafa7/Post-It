//
//  HomeViewController.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Post It"
        
    }
    
    
    @IBAction func allPostsButtonTapped(_ sender: UIButton) {
        print("Show all posts")
        let vc = PostsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createPostButtonTapped(_ sender: UIButton) {
        print("Create post")
    }
    
}
