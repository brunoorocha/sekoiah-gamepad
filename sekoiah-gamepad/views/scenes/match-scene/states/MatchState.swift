//
//  MatchState.swift
//  project-sekoiah
//
//  Created by Bruno Rocha on 04/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import GameplayKit

class MatchState: GKState {
    var matchScene: MatchScene!
    
    init(forMatchScene matchScene: MatchScene) {
        self.matchScene = matchScene
    }    
}
