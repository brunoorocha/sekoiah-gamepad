//
//  CharacterIdleState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterIdleState: CharacterState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        let idleAction = SKAction.animate(with: self.stateAtlasTextures, timePerFrame: 0.1)
        self.character.spriteNode.run(SKAction.repeatForever(idleAction))
    }
}
