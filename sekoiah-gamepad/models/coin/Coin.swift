//
//  Coin.swift
//  sekoiah-gamepad
//
//  Created by Bruno Rocha on 06/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit

class Coin: SKNode {
    
    var spriteNode: SKNode!
    
    override init() {
        super.init()
        self.zPosition = 2
        self.initSpriteNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSpriteNode() {
        self.spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "little_boo_coin_01"), size: CGSize(width: 32, height: 32))
        let coinAtlas = AtlasTextureBuilder.build(atlas: "coin")
        let animationAction = SKAction.animate(with: coinAtlas, timePerFrame: 0.2)
        self.spriteNode.run(SKAction.repeatForever(animationAction))
        self.addChild(self.spriteNode)
        self.initPhysicsBody()
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.spriteNode.frame)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CategoryMask.coin
    }
    
    func collected() {
        let moveAction = SKAction.moveBy(x: 0.0, y: 24.0, duration: 0.2)
        let fadeAction = SKAction.fadeOut(withDuration: 0.2)
        self.spriteNode.run(SKAction.group([moveAction, fadeAction])) {
            self.removeFromParent()
        }
    }
}
