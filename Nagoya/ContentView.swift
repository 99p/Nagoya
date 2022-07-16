//
//  ContentView.swift
//  Nagoya
//
//  Created by macboy on 2022/07/11.
//

import SwiftUI
import SpriteKit //1

class GameScene : SKScene{
    
    var bowl:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(
            x: self.size.width*0.5,
            y: self.size.height*0.5)
        background.size = self.size
        self.addChild(background)
        
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
        
        fallNagoyaSpecialty()
        
    }
    
    func fallNagoyaSpecialty(){
        
        let texture = SKTexture(imageNamed: "0")
        let sprite = SKSpriteNode(texture: texture)
        
        sprite.position = CGPoint(
            x: self.size.width*0.5,
            y: self.size.height*0.5)
        sprite.size = CGSize(
            width: texture.size().width*0.5,
            height: texture.size().height*0.5)
        
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        
        self.addChild(sprite)
        
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
