//
//  HTTPRequest.swift
//  HTTPRequest
//
//  Created by Tiep Nguyen on 11/20/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case GET, POST
    var toString: String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        }
    }
}

class HTTPRequest {

    class func GET(url: String, callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .GET, params: nil, callback: callback)
    }
    
    class func GET(url: String, params: [String: String], callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .GET, params: parseParam(params), callback: callback)
    }
    
    class func GET(url: String, params: String, callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .GET, params: params, callback: callback)
    }
    
    class func POST(url: String, callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .POST, params: nil, callback: callback)
    }
    
    class func POST(url: String, params: [String: String], callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .POST, params: parseParam(params), callback: callback)
    }
    
    class func POST(url: String, params: String, callback: (data: NSData?, text: String?, error: String?) -> ()) {
        makeRequest(url, method: .POST, params: params, callback: callback)
    }
    
    class func parseParam(params: [String: String]) -> String {
        var components: [String] = []
        for (key, value) in params {
            components.append(key + "=" + value)
        }
        return "&".join(components)
    }

    class func makeRequest(url: String, method: HTTPMethod, params: String?, callback: (data: NSData?, text: String?, error: String?) -> ()) {
        var query = ""
        var request = NSMutableURLRequest()
        println("HTTPRequest \(method.toString): \(url)")
        if params != nil {
            println("Params: \(params!)\n")
            if method == HTTPMethod.POST {
                request.HTTPBody = params!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            } else {
                if url.rangeOfString("?", options: nil, range: nil, locale: nil) == nil {
                    query += "?"
                } else {
                    query += "&"
                }
                query += params!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            }
        }
        request.URL = NSURL(string: url + query)!
        request.HTTPMethod = method.toString
        NSURLConnection.sendAsynchronousRequest(request, queue: .mainQueue()) { (response, data, error) -> Void in
            if error != nil {
                callback(data: data, text: nil, error: error.localizedDescription)
            } else {
                callback(data: data, text: NSString(data: data, encoding: NSUTF8StringEncoding) as? String, error: nil)
            }
        }
        /*
        NSURLConnection.sendAsynchronousRequest(request, queue: .mainQueue()) { (response, data, error) -> Void in
            if error != nil {
                callback(data: data, text: nil, error: error.localizedDescription)
            } else {
                callback(data: data, text: NSString(data: data, encoding: NSUTF8StringEncoding), error: nil)
            }
        }
        */
    }
    
}