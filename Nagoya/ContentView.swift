//
//  ContentView.swift
//  Nagoya
//
//  Created by macboy on 2022/07/11.
//

import SwiftUI
import SpriteKit //1

class GameScene : SKScene, SKPhysicsContactDelegate{
    
    // どんぶり
    var bowl:SKSpriteNode?
    
    // タイマー
    var timer: Timer?
    
    // 落下判定用シェイプ
    var lowestShape: SKShapeNode?
    
    // スコア用プロパティ
    var score = 0
    var scoreLabel: SKLabelNode?
    var scoreList = [100, 200, 300, 500, 800, 1000, 1500]
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(
            x: self.size.width*0.5,
            y: self.size.height*0.5)
        background.size = self.size
        self.addChild(background)
        
        // 落下検知用シェイプノードを追加
        let lowestShape = SKShapeNode(rectOf: CGSize(width: self.size.width*3, height: 10))
        lowestShape.position = CGPoint(x: self.size.width*0.5, y: -10)
//        lowestShape.fillColor = .blue
        
        // シェイプに合わせてPhysicsBodyを生成
        let physicsBody = SKPhysicsBody(rectangleOf: lowestShape.frame.size)
        physicsBody.isDynamic = false
        physicsBody.contactTestBitMask = 0x1 << 1 //衝突を検知する対象のビットマスクを指定
        lowestShape.physicsBody = physicsBody
        self.addChild(lowestShape)
        self.lowestShape = lowestShape
        
        let bowlTexture = SKTexture(imageNamed: "bowl")
        let bowl = SKSpriteNode(texture: bowlTexture)
        bowl.position = CGPoint(x: self.size.width*0.5, y: 100)
        bowl.size = CGSize(
            width: bowlTexture.size().width*0.5,
            height: bowlTexture.size().height*0.5)
        bowl.physicsBody = SKPhysicsBody(texture: bowlTexture, size: bowl.size)
        bowl.physicsBody?.isDynamic = false
        self.bowl = bowl
        self.addChild(bowl)
        
        // スコア用ラベル
        var scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.position = CGPoint(x: self.size.width*0.92, y: self.size.height*0.78)
        scoreLabel.text = "￥0"
        scoreLabel.fontSize = 32
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.fontColor = UIColor.green
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        self.fallNagoyaSpecialty()
        
        // タイマーを生成
        self.timer = Timer.scheduledTimer(timeInterval: 3,
                                          target: self,
                                          selector: #selector(fallNagoyaSpecialty),
                                          userInfo: nil,
                                          repeats: true)
        
    }
    
    
    @objc func fallNagoyaSpecialty(){
        
        let index = Int(arc4random_uniform(7))
        let texture = SKTexture(imageNamed: "\(index)")
        let sprite = SKSpriteNode(texture: texture)
        
        sprite.position = CGPoint(
            x: self.size.width*0.5,
            y: self.size.height)
        sprite.size = CGSize(
            width: texture.size().width*0.5,
            height: texture.size().height*0.5)
        
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        sprite.physicsBody?.contactTestBitMask = 0x1 << 1 //衝突を検知する対象のビットマスクを指定
        
        self.addChild(sprite)
        
        self.score += self.scoreList[index]
        self.scoreLabel?.text = "￥\(self.score)"
    }
    
    // タッチ開始時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: AnyObject = touches.first {
            let location = touch.location(in: self)
            let action = SKAction.move(to: CGPoint(x: location.x, y: 100), duration: 0.1)
            self.bowl?.run(action)
        }
    }
    
    // ドラッグ時
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let action = SKAction.move(to: CGPoint(x: location.x, y: 100), duration: 0.1)
            self.bowl?.run(action)
        }
    }
    
    // GameOver
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == self.lowestShape || contact.bodyB.node == self.lowestShape {
            let sprite = SKSpriteNode(imageNamed: "gameover")
            sprite.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
            self.addChild(sprite)
            self.isPaused = true
            self.timer?.invalidate()
        }
    }
    
}

struct ContentView: View {
    
    var scene: SKScene { //2
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        ZStack{
            SpriteView(scene: scene, debugOptions: [.showsFPS, .showsDrawCount])
//                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
