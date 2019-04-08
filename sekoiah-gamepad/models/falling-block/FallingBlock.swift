//
//  FallingBlock.swift
//  sekoiah-gamepad
//
//  Created by Bruno Rocha on 07/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit

class FallingBlock: SKNode {
    
    var spriteNode: SKSpriteNode!
    var blockSize = CGSize(width: 32, height: 32)
    static var blockTexture = SKTexture(imageNamed: "stone_brick_block_wall")
    
    override init() {
        super.init()
        self.zPosition = 3
        self.initSpriteNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSpriteNode() {
        self.spriteNode = SKSpriteNode(texture: FallingBlock.blockTexture, size: self.blockSize)
        self.addChild(spriteNode)
        self.initPhysicsBody()
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.blockSize)
        self.physicsBody?.linearDamping = 20
        self.physicsBody?.categoryBitMask = CategoryMask.fallingBlock
        self.physicsBody?.collisionBitMask = CategoryMask.character
        self.physicsBody?.contactTestBitMask = CategoryMask.character
        self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Float.pi), duration: 2.0)))
    }
}
