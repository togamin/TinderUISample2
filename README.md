## 【Swift4】Tinderのユーザーインターフェースの作成方法

[GitHub:Tinderのユーザーインターフェース](https://github.com/togamin/TinderUISample2.git)

```swift
//説明所要時間
2時間

```

### アプリの概要と実装の流れに関する説明

* アプリの概要

  * Tinder風のユーザーインターフェース。右か左で、カードをスワイプする方向によって、情報の処理のされ方を変えることができる。

    アプリを起動して説明

* - 右にスワイプすると、「rightList」にスワイプした画像の情報が入り、左にスワイプすると「leftList」にスワイプした情報が入る。
  - リセットボタンを押すと元に戻る。

* 実装の流れ 

  * ViewControllerに、2つのUIViewとImageViewを設置。手前のUIViewのみに「Pan Gesture Recognitionnizer」をつける。(ホワイトボードに概要書く)
  * カードを小さくスワイプした時の処理
    - 元の位置に戻す
  * カードを大きくスワイプした時の処理
    - スワイプした方向にカードを飛ばす。
    - 飛ばしたカードの情報を保持する。
    - 飛ばしたカードを透明にする。
    - 透明にした後、カードを元の位置に戻す。後ろのカードのデザインが見えている状態になる。
    - 手前のカードに、後ろのカードの情報を入れ込む。同じデザインのカードが2枚ある状態。手前は透明。
    - 手前のカードを見えるようにする。
    - 後ろのカードに、次のデータを入れる。
      - 最後から2枚目の場合と最後のカードの場合は場合分が必要。
      - なぜ場合分けが必要か。→「backCard」に入れる情報がなくなり、「Out of range」のエラーがでる。(ホワイトボードに概要書く)
  * カードをスワイプした時の動作に関するコードの説明。(ホワイトボードに概要書く)

### コードの実装

- NewFileの作成(TinderUISampe) 

- UIの配置とファイルへの紐付け。 

- - UIView2つ 
  - ImageView2つ 
  - 「Pan Gesture Recognitionnizer」つける
  - UIViewの位置関係に注意

- 変数の宣言

- ```swift
  //カードの情報関連
  var imageList:[String]!//スワイプする画像のリスト
  var cardNum:Int = 0//手前に入れる画像の番号が入る
  var nextCard:Int = 1//後ろに入れる画像の番号が入る
  var imageCount:Int!//用意している画像の数
  ```

- ViewDidLoad内に以下を追加

- ```swift
  //画像用意。
  imageList = ["animal01.png","animal02.png","animal03.png","animal04.png","animal05.png”]
  //画像の数。
  imageCount = imageList.count
  //カードに初期の画像を入れ込む
  frontCardImage.image = UIImage(named:imageList[cardNum])
  backCardImage.image = UIImage(named:imageList[nextCard])
  //画像がImageViewに比率を保ったまま収まるようにする
  cardImage.contentMode = .scaleAspectFit
  backCardImage.contentMode = .scaleAspectFit
  ```

- スワイプに関する処理を書く。処理に必要な変数の定義

- ```swift
  //手前のカードをスワイプした分だけ、横に動かし、動かした距離に応じて回転させる。「point.x」に0.1をかけているのは、スワイプした時に動きすぎないようにするため。
  swipeCard.center = CGPoint(x: swipeCard.center.x + point.x * 0.1,y:swipeCard.center.y)//スワイプした時にx座標だけ動かす。
  swipeCard.transform = CGAffineTransform(rotationAngle: swipeDistanceX/(view.frame.width/2) * -0.785)//Max45度の傾き。スワイプした距離に応じて傾きを変える
  ```

- スワイプ後、指が離れた時の処理を記入。右に大きく振れた時と、左に大きく振れた時と、小さく振れた時で場合分けをする。

- ```swift
  //スクリーンの幅の情報を取得
  var screenWidth:CGFloat!
  screenWidth = UIScreen.main.bounds.width
  ```

- ```swift
  //スワイプの指が離れたときの処理.
  if sender.state == UIGestureRecognizerState.ended{
      //処理を記入
      //左に大きく振れた時
      if swipeCard.center.x < self.screenWidth/5 {
          UIView.animate(withDuration: 0, animations: {
              
          })
      }
      //右に大きく振れた時
      else if swipeCard.center.x > self.screenWidth - self.screenWidth/5{
          UIView.animate(withDuration: 0, animations: {
              
          })
      }
      //小さく振れた時
      else {
          UIView.animate(withDuration: 0.2, animations: {
              
          })
      }
  }
  ```

- 小さく振れた時、カードを元の位置に戻す

- ```swift
  //カードのセンターの位置を代入する
  var cardCenter:CGPoint!
  cardCenter = frontCard.center
  ```

- ```swift
  //小さく振れた時、カードを元の位置に戻す
  swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
  swipeCard.transform = .identity
  ```

- 左に大きく振れた時の処理の流れを書く。

- ```swift
  //情報を入れる配列を定義
  var leftInfo:[String] = []
  
  //「flontCard」を画面外に飛ばす
  //カードが持つ情報を保持する
  //「flontCard」を透明にする
  //「flontCard」を元の位置の戻す
  //「backCard」の情報を「flontCard」に入れる
  //「flontCard」を見えるようにする
  //「backCard」の情報に次のカードの情報を入れる。カードが残り2枚の時のスワイプ時、「backCard」を消す。最後の1枚をスワイプした時、「flontCard」を消す。
  ```

- 左に大きく振れた時の処理の内容

- ```swift
  //「flontCard」を画面外に飛ばす
  swipeCard.center = CGPoint(x: self.cardCenter.x + self.screenWidth,y:self.cardCenter.y)
  //カードが持つ情報を保持する
  self.leftInfo.append(self.imageList[self.cardNum])
  print("左スワイプデータ：",self.leftInfo)
  //「flontCard」を透明にする
  swipeCard.alpha = 0
  //「flontCard」を元の位置の戻す
  swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
  swipeCard.transform = .identity
  //「backCard」の情報を「flontCard」に入れる
  self.frontCardImage.image = self.backCardImage.image
  //「flontCard」を見えるようにする
  swipeCard.alpha = 1
  //「backCard」の情報に次のカードの情報を入れる。カードが残り2枚の時のスワイプ時、「backCard」を消す。最後の1枚をスワイプした時、「flontCard」を消す。
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
  ```

- 右に大きく振れた時の処理も同じように。 

- リセットボタンの作成 

- ```swift
  rightInfo = []
  leftInfo = []
  cardNum = 0
  nextCard = 1
  frontCardImage.image = UIImage(named:imageList[cardNum])
  backCardImage.image = UIImage(named:imageList[nextCard])
  frontCard.alpha = 1
  backCard.alpha = 1
  ```







