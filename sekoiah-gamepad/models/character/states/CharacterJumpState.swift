//
//  CharacterJumpState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterJumpState: CharacterState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        let jumpAction = SKAction.animate(with: self.stateAtlasTextures, timePerFrame: 0.05)
        self.character.spriteNode.run(jumpAction) {
            self.stateMachine?.enter(CharacterFallState.self)            
        }
        
        if let physicsBody = self.character.physicsBody {
            physicsBody.velocity.dy = 0
            physicsBody.applyImpulse(CGVector(dx: 0.0, dy: 20))
        }
    }
}
