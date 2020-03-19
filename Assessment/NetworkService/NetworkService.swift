//
//  NetworkService.swift
//  Assessment
//
//  Created by VishalP India on 17/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

class  NetworkService: NSObject {
    
    static let sharedService = NetworkService()
    
    func dataFromURLPath<T: Decodable>(fileName: String, completion: @escaping (T?, _ error: Error?) -> ()) {
        if let path = Bundle.main.url(forResource: fileName, withExtension: FileExtension){
            let session = URLSession.shared
            let task = session.dataTask(with: path) { (data, response, error) in
                if let error = error{
                    completion(nil, error)
                    return
                }
                guard let dt = data else {
                    print("Error in Data API")
                    return
                }
                do{
                    let jsonObj = try JSONDecoder().decode(T.self, from: dt)
                    completion(jsonObj, nil)

                } catch let error{
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
}
