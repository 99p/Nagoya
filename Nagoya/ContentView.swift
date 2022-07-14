//
//  ContentView.swift
//  Nagoya
//
//  Created by macboy on 2022/07/11.
//

import SwiftUI
import SpriteKit //1

let bgColor = UIColor.gray

class GameScene : SKScene{
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(
            x: self.size.width*0.5,
            y: self.size.height*0.5)
        background.size = self.size
        self.addChild(background)
        
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
        
        self.addChild(sprite)
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
            Color(bgColor)
                .ignoresSafeArea()
            SpriteView(scene: scene, debugOptions: [.showsFPS, .showsDrawCount])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
