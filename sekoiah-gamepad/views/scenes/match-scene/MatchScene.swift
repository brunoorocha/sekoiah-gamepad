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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = .black
        
        let label = SKLabelNode(text: "Match Scene")
        self.addChild(label)
        self.initCamera()
        self.drawPlatform()
        self.instanceCharacter()
        self.initGamepad()
    }
    
    private func drawPlatform() {
        let platformNode = SKSpriteNode(texture: SKTexture(imageNamed: "brick-platform"))
        platformNode.position.y = -100.0
        platformNode.physicsBody = SKPhysicsBody(rectangleOf: platformNode.size)
        platformNode.physicsBody?.affectedByGravity = false
        platformNode.physicsBody?.isDynamic = false
        self.addChild(platformNode)
    }
    
    private func instanceCharacter() {
        self.character = Character()
        self.addChild(self.character)
    }
    
    private func initCamera() {
        let camera = SKCameraNode()
        self.camera = camera
        self.addChild(camera)
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
        
    }
    
    func joystickDidTapButtonA() {
        self.character.jump()
    }
    
    func joystickDidTapButtonB() {
        
    }
    
    func joystickDidTapDown() {
        
    }
}
