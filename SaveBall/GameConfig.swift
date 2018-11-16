//
//  GameConfig.swift
//  SaveBall
//
//  Created by user04 on 2018/9/1.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

enum GameLevel: String {
    case easy = "easy"
    case mid = "mid"
    case diff = "diff"
}

let uGameLevel = "gameLevel"
let uGameMusic = "isGameMusic"
let uGameSound = "isGameSound"

class GameConfig: NSObject {
    static let shared = GameConfig()
    
    var gameLevel: GameLevel = (UserDefaults.standard.string(forKey: uGameLevel) != nil) ? GameLevel(rawValue: UserDefaults.standard.string(forKey: uGameLevel)!)! : .easy {
        didSet {
            UserDefaults.standard.set(gameLevel.rawValue, forKey: uGameLevel)
            UserDefaults.standard.synchronize()
        }
    }
    
    var isGameMusic = UserDefaults.standard.object(forKey: uGameMusic) as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameMusic, forKey: uGameMusic)
            UserDefaults.standard.synchronize()
        }
    }
    var isGameSound = UserDefaults.standard.object(forKey: uGameSound) as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameSound, forKey: uGameSound)
            UserDefaults.standard.synchronize()
        }
    }
    
}
