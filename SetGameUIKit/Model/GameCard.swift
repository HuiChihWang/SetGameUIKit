//
//  GameCard.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import Foundation

struct GameCard {
    let shape: Shape
    let shading: Shading
    let number : Number
    let color: Color
    
    var isSelected = false
    var isMatched = false
    
    enum Shading: String, CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Shape: String, CaseIterable {
        case square = "■"
        case circle = "●"
        case triangle = "▲"
    }
    
    enum Number: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    enum Color: String, CaseIterable {
        case red
        case green
        case purple
    }
}

extension GameCard: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(shape)
        hasher.combine(shading)
        hasher.combine(number)
        hasher.combine(color)
    }
    
    static func ==(lhs: GameCard, rhs: GameCard) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
