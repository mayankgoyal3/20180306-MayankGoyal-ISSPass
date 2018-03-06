//
//  WebLayerManager.swift
//  ISSPassTimes
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import UIKit
import ReachabilitySwift

class WebLayerManager: NSObject {
    
    static let sharedInstance = WebLayerManager()
    let reachability = Reachability()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        config.timeoutIntervalForRequest = TimeInterval(90)
        config.timeoutIntervalForResource = TimeInterval(90)
        return URLSession(configuration: config)
    }()
    
    // Function used for execute service and return completion handle with Dictionary and Error
    func executeService(urlPath: String, httpMethodType: String, body: String?, completionHandler: @escaping (NSDictionary?, NSError?) -> Void) {
        if let reach = reachability?.isReachable, reach {
            URLCache.shared.removeAllCachedResponses()
            let storage = HTTPCookieStorage.shared
            if let cookies = storage.cookies {
                for cookie in cookies {
                    storage.deleteCookie(cookie)
                }
            }
            
            if let url = NSURL(string: urlPath) {
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = httpMethodType
                
                if let bodyString = body {
                    let jsonData = bodyString.data(using: .utf8, allowLossyConversion: false)
                    request.httpBody = jsonData
                }
                
                let task = session.dataTask(with: request as URLRequest) {data, response, error in
                    do {
                        if let data = data {
                            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                var statuscode :NSInteger?
                                if let httpResponse = response as? HTTPURLResponse {
                                    statuscode = httpResponse.statusCode
                                    if statuscode == 200 {
                                        completionHandler(jsonResult, nil)
                                    } else {
                                        if let status = jsonResult.object(forKey: "status") as? Int {
                                            let error = NSError(domain: "", code: status, userInfo: nil)
                                            completionHandler(nil, error)
                                        }
                                    }
                                }
                            }
                        } else {
                            if let error = error {
                                completionHandler(nil, error as NSError)
                            }
                        }
                    }
                    catch let error as NSError {
                        completionHandler(nil, error)
                    }
                }
                
                task.resume()
            }
        } else {
            let error = NSError(domain: "", code: -1009, userInfo: nil)
            completionHandler(nil, error)
        }
    }
}
