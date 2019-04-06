//
//  CharacterDieState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterDieState: CharacterState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        let dieAction = SKAction.animate(with: self.stateAtlasTextures, timePerFrame: 0.1)
//        let moveAction = SKAction.moveBy(x: 0, y: 32.0, duration: 0.5)
        self.character.spriteNode.run(SKAction.group([dieAction])) {
            self.character.removeFromParent()
        }
    }
}
