//
//  CharacterState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import GameplayKit

class CharacterState: GKState {
    
    var character: Character!
    var stateAtlasTextures: [SKTexture] = []
    
    init(forCharacter character: Character) {
        self.character = character
    }
    
}
