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
    
    func deletePost(urlString: String, parameters: [String: Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding parameters: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        
        task.resume()
    }
    
}


