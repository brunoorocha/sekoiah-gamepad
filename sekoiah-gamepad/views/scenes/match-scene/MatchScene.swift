//
//  MatchScene.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class MatchScene: SKScene {
    
    var stateMachine: GKStateMachine!
    var character: Character!
    var otherCharacter: Character!
    
    var aSecondAgo: TimeInterval = 0.0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = .black
        
        self.physicsWorld.contactDelegate = self
        self.initCamera()
        self.drawBackground()
        self.drawPlatforms()
        self.instanceCharacter()
        self.initGamepad()
        self.drawACoin()
    }
    
    private func drawPlatform(atPosition position: CGPoint = CGPoint.zero) {
        let platformNode = SKSpriteNode(texture: SKTexture(imageNamed: "brick-platform"))
        platformNode.position = position
        platformNode.zPosition = 1
        platformNode.physicsBody = SKPhysicsBody(rectangleOf: platformNode.size)
        platformNode.physicsBody?.affectedByGravity = false
        platformNode.physicsBody?.isDynamic = false
        platformNode.physicsBody?.categoryBitMask = CategoryMask.platform
        self.addChild(platformNode)
    }
    
    private func drawPlatforms() {
        self.drawPlatform(atPosition: CGPoint(x: 0, y: -64))
        self.drawPlatform(atPosition: CGPoint(x: 100, y: 64))
        self.drawPlatform(atPosition: CGPoint(x: -200, y: 192))
        self.drawPlatform(atPosition: CGPoint(x: 200, y: 320))
    }
    
    private func instanceCharacter() {
        self.character = Character()
        self.otherCharacter = Character()
        self.addChild(self.otherCharacter)
        self.addChild(self.character)
    }
    
    private func initCamera() {
        let camera = SKCameraNode()
        self.camera = camera
        self.addChild(camera)
//        self.camera?.run(SKAction.move(to: CGPoint(x: 0, y: 320), duration: 20.0))
    }
    
    private func initGamepad() {
        let inputSize = CGSize(width: self.size.width, height: self.size.height)
        let inputController = InputController(size: inputSize)
        inputController.zPosition = 10
        inputController.position = self.position
        inputController.joystickDelegate = self
        
        if let cam = self.camera {
            cam.addChild(inputController)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ((currentTime - self.aSecondAgo) > 5.0) {
            if (self.aSecondAgo != 0.0) {
                self.otherCharacter.die()
            }
            self.aSecondAgo = currentTime
        }
        
        self.otherCharacter.update()
        self.character.update()
    }
    
    private func drawACoin() {
        let coin = Coin()
        coin.position.y = 128.0
        self.addChild(coin)
    }
    
    private func drawBackground() {
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "brick-background"))
        self.addChild(background)
    }
}

extension MatchScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let colision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (colision == CategoryMask.character | CategoryMask.coin) {
            if let coin = contact.bodyA.node as! Coin? {
                coin.collected()
            }
            else if let coin = contact.bodyB.node as! Coin? {
                coin.collected()
            }
        }
    }
}

extension MatchScene: JoystickDelegate {
    func joystickDidStartTracking() {
        
    }
    
    func joystickDidMoved(direction: CGPoint) {
        self.character.move(inDirectionX: direction.x)
    }
    
    func joystickUpdateTracking(direction: CGPoint) {
        
    }
    
    func joystickDidEndTracking(direction: CGPoint) {
        self.character.idle()
    }
    
    func joystickDidTapButtonA() {
        self.character.jump()
    }
    
    func joystickDidTapButtonB() {
        
    }
    
    func joystickDidTapDown() {
        
    }
}
