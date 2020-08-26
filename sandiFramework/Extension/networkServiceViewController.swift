//
//  networkServiceViewController.swift
//  SJIalmofire
//
//  Created by adriansalim on 21/04/20.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration

public typealias HTTPHeaders = [String: String]
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
/*
 200 = Success get response from server
 400 = Bad request
 500 = Internal server error
 501 = No data from server
 503 = No connection
 */


public func apiResult(url: String, param: [String : Any]?, method: Alamofire.HTTPMethod, callback: @escaping (_ result: Bool, _ response: Any?, _ statusCode: String?) -> Void) {
    if(Reachability.getNetworkType() == "No Connection"){
        callback(false, "Please check your connection", "503")
    }
    else{
        let currentHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            ] as HTTPHeaders
        
        Alamofire.request(URL(string: url)!, method: method, parameters: param, encoding: URLEncoding.default, headers: currentHeaders)
            .responseJSON{ response in
                if(response.response == nil){
                    callback(false, nil, "501")
                }
                else{
                    let statusCode = response.response?.statusCode
                    switch statusCode!{
                    case 200:
                        callback(true, response.data, "200")
                    case 400:
                        print("Bad Request")
                        callback(false, nil, "400")
                        break
                    default:
                        callback(false, nil, "500")
                        break
                    }
                }
        }
    }
    
}

public func getIpAddress(callback: @escaping (_ ip: String?) -> Void) {
    Alamofire.request("https://api.ipify.org").responseString { (response) in
        if(response.value! != ""){
            callback(response.value!)
        }
        else{
            callback("")
        }
    }
}
