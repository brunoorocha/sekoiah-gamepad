//
//  PlayingMatchState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayingMatchState: MatchState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
}
