//
//  ContentView.swift
//  Nagoya
//
//  Created by macboy on 2022/07/11.
//

import SwiftUI
import SpriteKit //1

let bg = UIColor.gray

class GameScene : SKScene{
    override func didMove(to view: SKView) {
        backgroundColor = bg
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
            Color(bg)
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
