//
//  RequestManager.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

protocol RequestManagerProtocl {
    func request(url: String, parameters: JSON?, completion: @escaping completion)
    func parseResponse(response: URLResponse?,_ data: Data?, completion: @escaping completion)
}

public enum ResultRequest {
    case success(Data)
    case error(Error)
}

public typealias JSON = [ String : Any ]
public typealias completion = (ResultRequest) -> Void

class RequestManager: RequestManagerProtocl {
  
    static let shared = RequestManager()
    
    // MARK: - Request functions
    
    func request(url: String, parameters: JSON?, completion: @escaping completion) {
        print("\n\n<<< REQUEST PARAMS >>>\n\n >>> Url - \(url) \n >>> Params - \(parameters as AnyObject) \n >>>")
            
        guard let url = URL.init(string: url) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.parseResponse(response: response, data, completion: completion)
        }.resume()
    }
    
    func parseResponse(response: URLResponse?,_ data: Data?, completion: @escaping completion) {
        guard let currentResponse = response as? HTTPURLResponse else { completion(.error(RequestUtilities.getEmptyError())); return }
        
        let statusCode = currentResponse.statusCode
        let url = currentResponse.url?.absoluteString ?? "Empty URL"
        
        if statusCode == 200 {
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
                    print("\n\n<<< RESPONSE - SUCCESS - \(statusCode) >>>\n\n >>> Url - \(url) \n >>> Method - GET \n >>> Response - \(json) \n")
                    
                    completion(.success(data))
                } catch let error {
                    completion(.error(error))
                }
            }
        } else {
            print("\n\n<<< RESPONSE - ERROR - \(statusCode) >>>\n\n >>> Url - \(url) \n >>> Method - GET \n >>> \n")
            completion(.error(RequestUtilities.getEmptyError()))
        }
    }
    
}
