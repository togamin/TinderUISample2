//
//  ViewController.swift
//  TinderUISample2
//
//  Created by Togami Yuki on 2018/09/23.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontCard: UIView!
    @IBOutlet weak var frontCardImage: UIImageView!
    
    
    @IBOutlet weak var backCard: UIView!
    @IBOutlet weak var backCardImage: UIImageView!
    
    var imageList:[String]!
    var cardNum:Int = 0
    var nextCard:Int = 1
    var imageCount:Int!
    
    //カードのセンターの位置情報を入れる変数
    var cardCenter:CGPoint!
    // Screenの高さとScreenの幅を入れるための変数.後で使う.
    var screenWidth:CGFloat!
    
    //右,左にスワイプされた時に情報を入れる箱
    var rightInfo:[String] = []
    var leftInfo:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageList = ["animal01.png","animal02.png","animal03.png","animal04.png","animal05.png"]
        imageCount = imageList.count
        
        frontCardImage.image = UIImage(named:imageList[cardNum])
        backCardImage.image = UIImage(named:imageList[nextCard])
        
        frontCardImage.contentMode = .scaleAspectFit
        backCardImage.contentMode = .scaleAspectFit
        //カードのセンターの位置を代入。
        cardCenter = frontCard.center
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        
    }
    
    
    @IBAction func swipeAct(_ sender: UIPanGestureRecognizer) {
        //senderはドラックアンドドロップされたもの.スワイプされた時の情報.
        let swipeCard = sender.view!
        //どれくらいスワイプしたかの位置情報.
        let point = sender.translation(in:view)
        //スワイプ後のx座標とスワイプ前のx座標の差.プラスなら右、マイナスなら左に移動したことになる.
        let swipeDistanceX = swipeCard.center.x - view.center.x
        
        
        //基本となるカードスワイプした分カードを動かす。
        swipeCard.center = CGPoint(x: swipeCard.center.x + point.x * 0.1,y:swipeCard.center.y)//スワイプした時にx座標だけ動かす。
        swipeCard.transform = CGAffineTransform(rotationAngle: swipeDistanceX/(view.frame.width/2) * -0.785)//Max45度の傾き。スワイプした距離に応じて傾きを変える
        
        
        //スワイプの指が離れたときの処理.
        if sender.state == UIGestureRecognizerState.ended{
            
            //処理を記入
            //左に大きく振れた時
            if swipeCard.center.x < self.screenWidth/5 {
                UIView.animate(withDuration: 0, animations: {
                    //カードを画面外に飛ばす
                    swipeCard.center = CGPoint(x: self.cardCenter.x + self.screenWidth,y:self.cardCenter.y)
                    //スワイプされたカードの情報を保持
                    self.leftInfo.append(self.imageList[self.cardNum])
                    print("左スワイプデータ：",self.leftInfo)
                    //カードを透明にする
                    swipeCard.alpha = 0
                    //カードを元の位置に戻す
                    swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                    swipeCard.transform = .identity
                    //「backCard」の情報を「Card」に入れる
                    self.frontCardImage.image = self.backCardImage.image
                    //カードを見えるようにする
                    swipeCard.alpha = 1
                    //「backCard」の情報に次のカードの情報を入れる.カードが最後の一枚の時、「backCard」を消し、カードがなくなったら「card」も消す。
                    if self.cardNum < self.imageCount - 2{
                        self.cardNum += 1
                        self.nextCard += 1
                        self.backCardImage.image = UIImage(named:self.imageList[self.nextCard])
                    }else if self.cardNum == self.imageCount - 2{
                        self.cardNum += 1
                        self.backCard.alpha = 0
                    }else if self.cardNum == self.imageCount - 1{
                        self.frontCard.alpha = 0
                        print("カードがなくなりました。")
                    }
                })
            }
            //右に大きく振れた時
            else if swipeCard.center.x > self.screenWidth - self.screenWidth/5{
                UIView.animate(withDuration: 0, animations: {
                    //カードを画面外に飛ばす
                    swipeCard.center = CGPoint(x: self.cardCenter.x - self.screenWidth,y:self.cardCenter.y)
                    //スワイプされたカードの情報を保持
                    self.rightInfo.append(self.imageList[self.cardNum])
                    print("右スワイプデータ：",self.rightInfo)
                    //カードを透明にする
                    swipeCard.alpha = 0
                    //カードを元の位置に戻す
                    swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                    swipeCard.transform = .identity
                    //「backCard」の情報を「Card」に入れる
                    self.frontCardImage.image = self.backCardImage.image
                    //カードを見えるようにする
                    swipeCard.alpha = 1
                    //「backCard」の情報に次のカードの情報を入れる.カードが最後の一枚の時、「backCard」を消し、カードがなくなったら「card」も消す。
                    if self.cardNum < self.imageCount - 2{
                        self.cardNum += 1
                        self.nextCard += 1
                        self.backCardImage.image = UIImage(named:self.imageList[self.nextCard])
                    }else if self.cardNum == self.imageCount - 2{
                        self.cardNum += 1
                        self.backCard.alpha = 0
                    }else if self.cardNum == self.imageCount - 1{
                        self.frontCard.alpha = 0
                        print("カードがなくなりました。")
                    }
                })
            }
            //小さく振れた時
            else {
                UIView.animate(withDuration: 0.2, animations: {
                    swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                    swipeCard.transform = .identity
                })
            }
            
        }
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        rightInfo = []
        leftInfo = []
        cardNum = 0
        nextCard = 1
        frontCardImage.image = UIImage(named:imageList[cardNum])
        backCardImage.image = UIImage(named:imageList[nextCard])
        frontCard.alpha = 1
        backCard.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

