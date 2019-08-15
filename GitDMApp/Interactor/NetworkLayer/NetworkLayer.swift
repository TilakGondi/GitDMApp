//
//  NetworkLayer.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation

enum API403Error : Error {
    case RateLimitReached
}

class NetworkLayer {
    fileprivate var session:URLSession = URLSession(configuration: .default)
    
    func loadDataForUrl( url:URL, finished:@escaping (Data?,Error?)->Void){
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 403 {
                guard let data = data else{
                    print(error?.localizedDescription ?? "")
                    finished(nil,error)
                    return
                }
                finished(data,API403Error.RateLimitReached)
            }else if httpResponse.statusCode == 200 {
                guard let data = data else{
                    print(error?.localizedDescription ?? "")
                    finished(nil,error)
                    return
                }
                finished(data,nil)
            }
        }
        task.resume()
    }
    
  
}
