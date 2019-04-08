//
//  BlockMachine.swift
//  sekoiah-gamepad
//
//  Created by Bruno Rocha on 07/04/19.
//  Copyright © 2019 Bruno Rocha. All rights reserved.
//

import SpriteKit
import GameplayKit

class BlockMachine {
    
    var scene: SKScene!
    var blockGenerationInterval: TimeInterval = 5.0
    var lastBlockGeneration: TimeInterval = 0.0
    var isEnabled = true
    lazy var blockPool: [FallingBlock] = [FallingBlock(),  FallingBlock(), FallingBlock(), FallingBlock(), FallingBlock()]
    var currentBlockPoolIndex = 0
    
    init(forScene scene: SKScene) {
        self.scene = scene
    }
    
    func update(_ currentTime: TimeInterval) {
        if (self.isEnabled && (currentTime - self.lastBlockGeneration >= self.blockGenerationInterval)) {
            self.lastBlockGeneration = currentTime
            let block = self.blockPool[currentBlockPoolIndex]
            block.position = CGPoint(x: self.generateARandomPositionX(), y: 200)
            
            if block.scene == nil {
                self.scene.addChild(block)
            }
            
            self.currentBlockPoolIndex = self.currentBlockPoolIndex == self.blockPool.count - 1 ? 0 : self.currentBlockPoolIndex + 1
        }
    }
    
    private func generateARandomPositionX() -> CGFloat {
        let xValueRange = Int(self.scene.size.width / 2)
        let xRandom = GKRandomDistribution(lowestValue: -xValueRange, highestValue: xValueRange).nextInt()
        return CGFloat(xRandom)
    }
}
