//
//  PostsViewController.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import UIKit

class PostsViewController: UIViewController {
    
    var posts = [Post]()

    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        
        title = "Posts"
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        getPosts()
        
    }
    
    func getPosts(){
        APIManager.shared.fetchPosts { response in
            switch response {
            case .success(let posts):
                self.posts = posts
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TableView delegate
extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postsTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableView dataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell
        cell?.configureCell(title: posts[indexPath.row].title ?? "Empty", ImageURL: posts[indexPath.row].imageURL ?? "" )
        return cell ?? UITableViewCell()
    }
    
    
}
