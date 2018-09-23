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
    
    //カードのセンターの位置情報を入れる変数
    var cardCenter:CGPoint!
    // Screenの高さとScreenの幅を入れるための変数。後で使う。
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageList = ["animal01.png","animal02.png","animal03.png","animal04.png","animal05.png"]
        
        //カードのセンターの位置を代入。
        cardCenter = card.center
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
    }
    
    
    @IBAction func swipeAct(_ sender: UIPanGestureRecognizer) {
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

