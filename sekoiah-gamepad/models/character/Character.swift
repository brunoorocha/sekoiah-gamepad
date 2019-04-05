//
//  Character.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class Character: SKNode {
    
    var spriteNode: SKSpriteNode!
    var stateMachine: GKStateMachine!
    
    override init() {
        super.init()
        self.initStateMachine()
        self.initSpriteNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initStateMachine() {
        let idleState = CharacterIdleState(forCharacter: self)
        idleState.stateAtlasTextures = AtlasTextureBuilder.build(atlas: "littleboo-idle")
        
        let jumpState = CharacterJumpState(forCharacter: self)
        jumpState.stateAtlasTextures = AtlasTextureBuilder.build(atlas: "littleboo-jump")
        
        self.stateMachine = GKStateMachine(states: [idleState, jumpState])
    }
    
    private func initSpriteNode() {
        self.spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "little_boo_idle2"), size: CGSize(width: 32, height: 32))
        self.initPhysicsBody()
        self.addChild(self.spriteNode)
        self.idle()
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.spriteNode.size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.allowsRotation = false
    }
    
    func jump() {
        self.stateMachine.enter(CharacterJumpState.self)
    }
    
    func idle() {
        self.stateMachine.enter(CharacterIdleState.self)
    }
    
    func move(inDirectionX directionX: CGFloat) {
        let direction: CGFloat = directionX < 0 ? -1.0 : 1.0
        self.xScale = abs(self.xScale) * direction
    }
}
