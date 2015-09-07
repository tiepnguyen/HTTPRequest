//
//  ViewController.swift
//  HTTPRequest
//
//  Created by Tiep Nguyen on 11/20/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "http://beta.superghs.com/api/voucher/896"
        
        HTTPRequest.GET(url, callback: { (data, text, error) -> () in
//            println(data)
//            println(text)
//            println(error)
            var decodeError: NSError?
            let json = JSON(data: data!)
            println(json["procedure"].stringValue)
            let jsonDict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &decodeError) as NSDictionary
            println(jsonDict)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

