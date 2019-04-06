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
    var velocity: CGFloat = 8
    var jumpCount = 0
    var jumpCountMax = 2
    
    override init() {
        super.init()
        self.zPosition = 2
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
        
        let fallState = CharacterFallState(forCharacter: self)
        fallState.stateAtlasTextures = AtlasTextureBuilder.build(atlas: "littleboo-fall")
        
        let moveState = CharacterMoveState(forCharacter: self)
        
        let dieState = CharacterDieState(forCharacter: self)
        dieState.stateAtlasTextures = AtlasTextureBuilder.build(atlas: "littleboo-die")
        
        self.stateMachine = GKStateMachine(states: [idleState, jumpState, fallState, moveState, dieState])
    }
    
    private func initSpriteNode() {
        self.spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "little_boo_idle2"), size: CGSize(width: 48, height: 48))
        self.initPhysicsBody()
        self.addChild(self.spriteNode)
        self.idle()
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 16, center: CGPoint(x: 0, y: -6.0))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.04
        self.physicsBody?.friction = 0.5
        self.physicsBody?.categoryBitMask = CategoryMask.character
        self.physicsBody?.collisionBitMask = CategoryMask.platform
        self.physicsBody?.collisionBitMask &= ~CategoryMask.character
        self.physicsBody?.contactTestBitMask = CategoryMask.coin
    }
    
    func jump() {        
        if (self.jumpCount < self.jumpCountMax) {
            self.stateMachine.enter(CharacterJumpState.self)
            self.jumpCount += 1
        }
    }
    
    func idle() {
        self.stateMachine.enter(CharacterIdleState.self)
    }
    
    func move(inDirectionX directionX: CGFloat) {
        let direction: CGFloat = directionX < 0 ? -1.0 : 1.0
        self.xScale = abs(self.xScale) * direction
        self.stateMachine.enter(CharacterMoveState.self)
        
        self.physicsBody?.velocity.dx = 0
        self.physicsBody?.applyImpulse(CGVector(dx: direction * self.velocity, dy: 0.0))
    }
    
    func die() {
        self.stateMachine.enter(CharacterDieState.self)
    }
    
    func update() {
        if (self.physicsBody?.velocity.dy == 0) {
            self.jumpCount = 0
        }
    }
}
