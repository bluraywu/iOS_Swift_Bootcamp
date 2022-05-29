//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Ray WU on 28/05/2022.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var posts = [Post]()

    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = result.hits
                            }
                        } catch {
                            print(error)
                        }

                    }
                }
            }
            task.resume()
        }
    }
}
