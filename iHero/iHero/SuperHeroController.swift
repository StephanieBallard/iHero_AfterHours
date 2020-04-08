//
//  SuperHeroController.swift
//  iHero
//
//  Created by Stephanie Ballard on 4/7/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

class SuperHeroController {
    let token = "10100896649479593"
    private let baseURL = URL(string: "https://superheroapi.com/api/")!
    lazy var authURL = baseURL.appendingPathComponent(token)
    lazy var searchURL = authURL.appendingPathComponent("search")
    
    func downloadSuperHero(name: String, completion: @escaping ([Hero]?) -> Void) {
        let nameURL = searchURL.appendingPathComponent(name)
        URLSession.shared.dataTask(with: nameURL) { (data, response, error) in
            if let error = error {
                print("Error downloading Superhero: \(error)")
                //NSLog puts the error on the device log and can help you trace down why the app crashed on their phone.
                completion(nil)
                return
            }
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("Bad Status Code: \(statusCode)")
                    completion(nil)
                    return
                }
            }
            // when you are decoding you are creating instances of what you are decoding
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let searchResult = try jsonDecoder.decode(SearchResult.self, from: data)
                    completion(searchResult.results)
                    print(searchResult.results)
                } catch let decodeError {
                    print("Error decoding Hero: \(decodeError)")
                }
            }
        }.resume()
    }
}
