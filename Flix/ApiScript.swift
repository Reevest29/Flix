//
//  ApiScript.swift
//  Flix
//
//  Created by user145843 on 4/11/19.
//  Copyright © 2019 T3Tech. All rights reserved.
//

import Foundation


class API {
    // Gets the posts json data and returns it converted as a dictionary
    func getPosts(completion: @escaping ([String: Any]?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                return completion((dataDictionary))
                }
            }
        task.resume()
    }
}
