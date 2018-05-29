//
//  Shared.swift
//  SuggestionBar
//
//  Created by Ricardo V Del Frari on 28/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class Manager {
    
    static let shared = Manager()
    
    let fruitSuggestions: [Fruits] = [
        Fruits(name: "Apple", emoji: "🍎"),
        Fruits(name: "Avocado", emoji: "🥑"),
        Fruits(name: "Banana", emoji: "🍌"),
        Fruits(name: "Cherry", emoji: "🍒"),
        Fruits(name: "Coconut", emoji: "🥥"),
        Fruits(name: "Lemon", emoji: "🍋"),
        Fruits(name: "Melon", emoji: "🍈"),
        Fruits(name: "Kiwi", emoji: "🥝"),
        Fruits(name: "Pear", emoji: "🍐"),
        Fruits(name: "Watermelon", emoji: "🍉"),
        Fruits(name: "Grape", emoji: "🍇"),
        Fruits(name: "Strawberry", emoji: "🍓"),
        Fruits(name: "Peach", emoji: "🍑"),
        Fruits(name: "Pineapple", emoji: "🍍"),
        Fruits(name: "Tomatoe", emoji: "🍅"),
        Fruits(name: "Tangerine", emoji: "🍊")
    ]
}
