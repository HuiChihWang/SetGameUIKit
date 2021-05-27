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
    
    private var allCards = [GameCard]()
    
    private var selectedCards = [GameCard]()
    
    private(set) var cardsOnTable = [GameCard]()
    
    private var setMatched = [[GameCard]]()
    
    var numberOfLeftCards: Int {
        allCards.count
    }
    
    private var isSetFull: Bool {
        selectedCards.count == SetGame.numberPerSet
    }
    
    private var isSetMatch: Bool {
        SetGame.isSetMatch(cardsInSet: selectedCards)
    }
    
    init() {
        newGame()
    }
    
    func selectCard(by selectIndex: Int) {
        guard !cardsOnTable[selectIndex].isEmptyCard else {
            print("select on empty space")
            return
        }
        
        // check if previous 3 card match
        if isSetFull {
            let selectedIndexes = selectedCards.map { card in
                return cardsOnTable.firstIndex(of: card)
            }
            
            if selectedIndexes.contains(selectIndex) {
                return
            }
            
            if isSetMatch {
                moveMatchedCardSet()
            }
            else {
                selectedCards.forEach { card in
                    deselectCardOnTable(on: card)
                }
                
                selectedCards = [GameCard]()
            }
        }
        
        let cardSelect = cardsOnTable[selectIndex]
        
        if let index = selectedCards.firstIndex(of: cardSelect) {
            // if card is already select -> deselect card, remove from set
            selectedCards.remove(at: index)
        }
        else {
            // if card is not in selected cards -> add card to set
            selectedCards.append(cardSelect)
        }
        
        // if there're 3 cards in the set and match
        if isSetFull && isSetMatch {
            selectedCards.forEach { matchCard in
                if let index = cardsOnTable.firstIndex(of: matchCard) {
                    cardsOnTable[index].isMatched = true
                }
            }
            
            print("set match")
        } else {
            if isSetFull {
                print("unmatch")
            }
        }
        
        // change selected status
        cardsOnTable[selectIndex].isSelected.toggle()
        
        print("select at (shape: \(cardSelect.shape), shading: \(cardSelect.shading), color: \(cardSelect.color), number: \(cardSelect.number)")
    }
    
    func dealThreeMoreCards() {
        drawCardsToDeck(numberOfCards: 3)
    }
    
    func newGame() {
        setMatched = [[GameCard]]()
        selectedCards = [GameCard]()
        allCards = [GameCard]()
        cardsOnTable = [GameCard]()
        createFullStackOfCards()
        drawCardsToDeck(numberOfCards: SetGame.initialCarNumber)
    }
    
    private func deselectCardOnTable(on card: GameCard) {
        if let index = cardsOnTable.firstIndex(of: card) {
            cardsOnTable[index].isSelected = false
        }
    }
    
    private func moveMatchedCardSet() {
        setMatched.append(selectedCards)
        selectedCards.forEach { card in
            removeCardFromTable(with: card)
        }
        selectedCards = [GameCard]()
    }
    
    private func createFullStackOfCards() {
        allCards = [GameCard]()
        GameCard.Number.allCases.forEach { number in
            GameCard.Shape.allCases.forEach { shape in
                GameCard.Shading.allCases.forEach { shading in
                    GameCard.Color.allCases.forEach { color in
                        allCards.append(GameCard(shape: shape, shading: shading, number: number, color: color))
                    }
                }
            }
        }
        allCards.shuffle()
    }
    
    private func drawCardsToDeck(numberOfCards: Int) {
        let numberDraw = min(numberOfLeftCards, numberOfCards)
        (0 ..< numberDraw).forEach { index in
            let sampleCard = allCards.remove(at: index)
            cardsOnTable.append(sampleCard)
        }
    }
    
    private func drawOneCardFromDeck() -> GameCard? {
        if let cardIndex = allCards.indices.randomElement() {
            return allCards.remove(at: cardIndex)
        }
        return nil
    }
    
    private func removeCardFromTable(with card: GameCard) {
        if let index = cardsOnTable.firstIndex(of: card) {
            cardsOnTable[index] = drawOneCardFromDeck() ?? GameCard.createEmptyCard()
        }
    }
    
    private static func isSetMatch(cardsInSet: [GameCard]) -> Bool {
        guard cardsInSet.count == SetGame.numberPerSet else {
            return false
        }
        
        let shapeList = cardsInSet.map { $0.shape }
        let shadingList = cardsInSet.map { $0.shading }
        let numberList = cardsInSet.map { $0.number }
        let colorList = cardsInSet.map { $0.color }
        
        return shapeList.isAllSameOrAllDifferent && shadingList.isAllSameOrAllDifferent && numberList.isAllSameOrAllDifferent && colorList.isAllSameOrAllDifferent
    }
    
}

extension Collection where Element: Hashable {
    var isAllSameOrAllDifferent: Bool {
        var set = Set<Element>()
        self.forEach { set.insert($0) }
        return set.count == count || set.count == 1
    }
}
