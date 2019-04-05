//
//  PrepareToMatchState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//
//  This class describe the behavior of MatchScene when it's on preparing state

import SpriteKit
import GameplayKit

class PrepareToMatchState: MatchState {
    
    /// A match just can go from prepare to playing state only
    ///
    /// - Parameter stateClass: the state that will enter
    /// - Returns: just return true for PlayingMatchState
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingMatchState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
}
