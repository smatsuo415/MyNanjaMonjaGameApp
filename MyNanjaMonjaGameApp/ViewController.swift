//
//  ViewController.swift
//  MyNanjaMonjaGameApp
//
//  Created by Shugo Matsuo on 2020/10/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scoreBtn: [UIButton]!
    @IBOutlet var changeImageBtn: [UIButton]!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var imageViewTest: UIImageView!
    @IBOutlet weak var cardStock: UILabel!
    @IBOutlet weak var cardRemain: UILabel!
    let imageMaxNum: Int = 12
    let imageOneNum: Int = 5
    let cardMaxNum: Int = 12 * 5
    var imageStart: UIImage!
    var imageGoal: UIImage!
    var imageArray = [UIImage]()
    var cardNum: Int = 0
    var cardArray: [Int] = [Int]()
    var cardFlag: [Bool] = [Bool]()
    var stockCard: Int = 0
    
    // カード取得
    @IBAction func getCard(_ sender: UIButton) {
        var score: Int! = (Int)(sender.title(for: UIControl.State.normal)!)
        
        score += stockCard
        let scoreString: String = (String)(score!)
        
        sender.setTitle(scoreString, for: UIControl.State.normal)
        
        // ボタン制御
        for btn in scoreBtn {
            btn.isEnabled = false
        }
        
        // カードストック初期化
        stockCard = 0
        cardStock.text = String(stockCard)
    }
    
    // カードめくり
    @IBAction func nextCardButton(_ sender: UIButton) {
        
        imageViewTest.image = nil
        
        if cardNum <= 0 {
            // ゲーム終了
            imageViewTest.image = imageGoal
            
            // ボタン制御
            for btn in changeImageBtn {
                btn.isEnabled = false
            }
        }
        else {
            
            cardNum -= 1
            cardRemain.text = String(cardNum)
            
            print("[DEBUG] card: \(cardArray[cardNum])")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.imageViewTest.image = self.imageArray[self.cardArray[self.cardNum]]
            }
            
            // ボタン制御
            if cardFlag[cardArray[cardNum]] == true {
                for btn in scoreBtn {
                    btn.isEnabled = true
                }
            }
            else {
                cardFlag[cardArray[cardNum]] = true
            }
            
            // カードストック
            stockCard += 1
            cardStock.text = String(stockCard)
        }
    }
    
    // ゲーム初期化
    @IBAction func gameRestart(_ sender: Any) {
        imageViewTest.image = imageStart
        cardNum = cardMaxNum
        cardRemain.text = String(cardNum)
        for index in 0..<cardFlag.count {
            cardFlag[index] = false
        }
        // スコア初期化
        for btn in scoreBtn {
            btn.setTitle("0", for: UIControl.State.normal)
        }
        // ボタン制御
        for btn in scoreBtn {
            btn.isEnabled = false
        }
        for btn in changeImageBtn {
            btn.isEnabled = true
        }
        
        // カードストック初期化
        stockCard = 0
        cardStock.text = String(stockCard)
        
        // カードシャッフル
        cardArray.shuffle()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 上部ボタン反転
        changeImageBtn[0].transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        scoreBtn[0].transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        scoreBtn[1].transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        // サイドボタン90度回転
        scoreBtn[4].transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
        scoreBtn[5].transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2.0)
        
        
        // スコアボタン丸め
        for btn in scoreBtn {
            btn.layer.cornerRadius = 50
        }
        // カードめくりボタン丸め
        for btn in changeImageBtn {
            btn.layer.cornerRadius = 20
        }
        // リスタートボタン丸め
        restartBtn.layer.cornerRadius = 20
        // カードストックラベル丸め
        cardStock.layer.cornerRadius = 50
        cardStock.clipsToBounds = true
        // 残りカードラベル丸め
        cardRemain.layer.cornerRadius = 50
        cardRemain.clipsToBounds = true
        
        // 画像登録
        imageStart = UIImage(named: "start")
        imageArray.append(UIImage(named: "img1")!)
        imageArray.append(UIImage(named: "img2")!)
        imageArray.append(UIImage(named: "img3")!)
        imageArray.append(UIImage(named: "img4")!)
        imageArray.append(UIImage(named: "img5")!)
        imageArray.append(UIImage(named: "img6")!)
        imageArray.append(UIImage(named: "img7")!)
        imageArray.append(UIImage(named: "img8")!)
        imageArray.append(UIImage(named: "img9")!)
        imageArray.append(UIImage(named: "img10")!)
        imageArray.append(UIImage(named: "img11")!)
        imageArray.append(UIImage(named: "img12")!)
        imageGoal = UIImage(named: "goal")
        
        // 既出カードフラグ
        for card in 0..<imageMaxNum {
            cardFlag.append(false)
            print("cardFlag[\(card)]: \(cardFlag[card])")
        }
        
        // カードデッキ構築
        for i in 0..<imageMaxNum {
            for j in 0..<imageOneNum {
                cardArray.append(i)
                print("\(j)")
            }
        }
        print("[DEBUG] cardArray: \(cardArray)")
        cardArray.shuffle()
        print("[DEBUG] shuffle cardArray: \(cardArray)")
        
        // ボタン制御
        for btn in scoreBtn {
            btn.isEnabled = false
        }
        
        imageViewTest.image = imageStart
        cardNum = cardMaxNum
        cardRemain.text = String(cardNum)
    }
}

