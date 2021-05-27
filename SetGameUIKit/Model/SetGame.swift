//
//  SetGame.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import Foundation

class SetGame {
    private static let initialCarNumber = 12
    private static let numberPerSet = 3
    
    private var AllCards = [GameCard]()
    
    private var selectedCards = [GameCard]()
    
    private(set) var cardsOnTable = [GameCard]()
    
    var numberOfLeftCards: Int {
        AllCards.count
    }
    
    init() {
        newGame()
    }
    
    func selectCard(by index: Int) {
        guard cardsOnTable.indices.contains(index) else {
            return
        }
        
        cardsOnTable[index].isSelected.toggle()
    }
    
    func dealThreeMoreCards() {
        drawCardsToDeck(numberOfCards: 3)
    }
    
    func  newGame() {
        createFullStackOfCards()
        drawCardsToDeck(numberOfCards: SetGame.initialCarNumber)
    }
    
    private func createFullStackOfCards() {
        AllCards = [GameCard]()
        GameCard.Number.allCases.forEach { number in
            GameCard.Shape.allCases.forEach { shape in
                GameCard.Shading.allCases.forEach { shading in
                    AllCards.append(GameCard(shape: shape, shading: shading, number: number))
                }
            }
        }
        AllCards.shuffle()
    }
    
    private func drawCardsToDeck(numberOfCards: Int) {
        (0 ..< numberOfCards).forEach { index in
            let sampleCard = AllCards.remove(at: index)
            cardsOnTable.append(sampleCard)
        }
    }
    
    private func isSetMatch(cardsInSet: [GameCard]) -> Bool {
        guard cardsInSet.count == SetGame.numberPerSet else {
            return false
        }
        
        let shapeList = cardsInSet.map { $0.shape }
        let shadingList = cardsInSet.map { $0.shading }
        let numberList = cardsInSet.map { $0.number }
        
        return shapeList.isAllSameOrAllDifferent && shadingList.isAllSameOrAllDifferent && numberList.isAllSameOrAllDifferent
    }

}

extension Collection where Element: Hashable {
    var isAllSameOrAllDifferent: Bool {
        var set = Set<Element>()
        self.forEach { set.insert($0) }
        return set.count == count || set.count == 1
    }
}
