//
//  APIProtocol.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    var APPID: String { get }
    var host: String { get }
    var api_version: String { get }
}

extension ServiceProtocol {
    func request(postfix: String, parameters: [String:Any]?, failure: @escaping ItemClosure<Error>, complition: @escaping ItemClosure<Data> ) {
        Alamofire.request("\(host)/\(api_version)\(postfix)", method: .get, parameters:
            parameters).responseJSON { response in
                guard response.result.isSuccess else {
                    failure(response.result.error!)
                    return
                }
                print(response.request?.url?.absoluteString)
                complition(response.data!)
        }
    }
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}
