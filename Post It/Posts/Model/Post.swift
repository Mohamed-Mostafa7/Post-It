//
//  Post.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import Foundation

struct Post: Codable {
    
    var id: Int?
    var title: String?
    var message: String?
    var imageURL: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "post_title"
        case message = "post_message"
        case imageURL = "post_image"
        
    }
}
