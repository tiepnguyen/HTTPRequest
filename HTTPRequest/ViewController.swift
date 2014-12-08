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

        let url = "http://localhost/json.php"
        
        HTTPRequest.GET(url, callback: { (response, error) -> () in
            println(response)
            println(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

