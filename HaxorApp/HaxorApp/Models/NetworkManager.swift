//
//  NetworkManager.swift
//  HaxorApp
//
//  Created by Rizal Fahrudin on 28/09/21.
//

import Foundation


class NetworkManager: ObservableObject {
    
    @Published var posts = [Posts]()
    
    func fetchList() {
        let url =  URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")
        
        if let safeURL = url {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: safeURL) { data, _, error in
                if let hasError = error {
                    print(hasError.localizedDescription)
                } else {
                    if let hasData = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let results = try jsonDecoder.decode(Results.self, from: hasData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
}
