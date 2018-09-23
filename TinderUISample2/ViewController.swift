//
//  ViewController.swift
//  TinderUISample2
//
//  Created by Togami Yuki on 2018/09/23.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var backCard: UIView!
    @IBOutlet weak var backCardImage: UIImageView!
    
    var imageList:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageList = ["animal01.png","animal02.png","animal03.png","animal04.png","animal05.png"]
        
        
    }
    
    
    @IBAction func swipeAct(_ sender: UIPanGestureRecognizer) {
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

