//
//  NetworkingManager.swift
//  Post It
//
//  Created by Mohamed Mostafa on 23/08/2023.
//

import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    // MARK: - Get posts
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let urlString = "https://task.astra-tech.net/fronendtask/public/api/getposts"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            // JSONDecoder() converts data to model of type Array
            do {
                let products = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(products))
            }
            catch {
                completion(.failure(DataError.message(error)))
            }
        }.resume()
    }
    
}


