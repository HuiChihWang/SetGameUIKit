//
//  SetGame.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import Foundation

class SetGame {
    static let initialCardNumber = 12
    static let maximumAvailableCards = 18
    static let numberPerSet = 3
    
    private var allCards = [GameCard]()
    
    private var selectedCards = [GameCard]()
    
    private var setMatched = [[GameCard]]()

    private(set) var cardsOnTable = [GameCard]()
    
    private(set) var score = 0
    
    var numberOfLeftCards: Int {
        allCards.count
    }
    
    var isDealAllowed: Bool {
        cardsOnTable.count < SetGame.maximumAvailableCards && numberOfLeftCards > 0
    }
    
    private var isSetMatch: Bool {
        SetGame.isSetMatch(cardsInSet: selectedCards)
    }
    
    private var isSetFull: Bool {
        selectedCards.count == SetGame.numberPerSet
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
            
            score += 1
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
        guard isDealAllowed else {
            return
        }
        
        if isSetMatch {
            moveMatchedCardSet()
            return
        }
        
        drawCardsToDeck(numberOfCards: 3)
    }
    
    func reDealCards() {
        if !isSetMatch {
            deselectAllCardsOnTable()
        }
        else {
            moveMatchedCardSet()
        }
        
        allCards += cardsOnTable
        allCards.shuffle()
        
        cardsOnTable = [GameCard]()
        drawCardsToDeck(numberOfCards: SetGame.initialCardNumber)
    }
    
    
    func newGame() {
        score = 0
        setMatched = [[GameCard]]()
        selectedCards = [GameCard]()
        allCards = [GameCard]()
        cardsOnTable = [GameCard]()
        createFullStackOfCards()
        drawCardsToDeck(numberOfCards: SetGame.initialCardNumber)
    }
    
    private func deselectAllCardsOnTable() {
        cardsOnTable.forEach {deselectCardOnTable(on: $0)}
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
        var count = 0
        GameCard.Number.allCases.forEach { number in
            GameCard.Shape.allCases.forEach { shape in
                GameCard.Shading.allCases.forEach { shading in
                    GameCard.Color.allCases.forEach { color in
                        // TODO: Reove debug use code
                        if count < 15 || true {
                            allCards.append(GameCard(shape: shape, shading: shading, number: number, color: color))
                            count += 1
                        }
                    }
                }
            }
        }
        allCards.shuffle()
    }
    
    private func drawCardsToDeck(numberOfCards: Int) {
        (0 ..< numberOfCards).forEach { _ in
            if let sampleCard = drawOneCardFromDeck() {
                cardsOnTable.append(sampleCard)
            }
        }
    }
    
    private func drawOneCardFromDeck() -> GameCard? {
        guard !allCards.isEmpty else {
            return nil
        }
        
        return allCards.removeLast()
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
