//
//  CharacterFallState.swift
//  sekoiah-gamepad
//
//  Created by Bruno Rocha on 05/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterFallState: CharacterState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {        
        let fallAction = SKAction.animate(with: self.stateAtlasTextures, timePerFrame: 0.05)
        self.character.spriteNode.run(fallAction) {
            self.stateMachine?.enter(CharacterIdleState.self)
        }        
    }
}
