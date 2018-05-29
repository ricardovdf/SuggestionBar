//
//  FruitsImputTextField.swift
//  SuggestionBar
//
//  Created by Ricardo V Del Frari on 28/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class FruitsImputTextField: UITextField, UITextFieldDelegate {
    
    //MARK: Properties
    @objc dynamic var filteredSuggestions = [String]()
    @objc dynamic var newItemFromTextField = [String]()
    
    let addFruitToListButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(imageLiteralResourceName: "addFruit").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.frame.size = CGSize(width: 44, height: 44)
        button.addTarget(self, action: #selector(handleAddFruitFromTextField), for: .touchUpInside)
        return button
    }()
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.autocorrectionType = UITextAutocorrectionType.no
        self.returnKeyType = UIReturnKeyType.send
        self.autocapitalizationType = UITextAutocapitalizationType.words
        self.placeholder = "Fruit"
        self.rightView = addFruitToListButton
        self.rightViewMode = .always
    }
    
    //MARK: TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fruitString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string)
        
        if fruitString.count > 0 {
            searchForSuggestionWith(fruitString)
        }else {
            textField.text?.removeAll()
            filteredSuggestions = []
        }
        
        return true
    }
    
    //MARK: Suggestion Methods
    func searchForSuggestionWith(_ string: String) {

        let matchingTerms = Manager.shared.fruitSuggestions.filter({
            $0.name.range(of: string, options: .caseInsensitive) != nil && $0.name.range(of: string)?.lowerBound.hashValue == 0
        })
        
        var arrayToSearch = [String]()
        for fruit in matchingTerms {
            arrayToSearch.append(fruit.emoji)
        }
        
        filteredSuggestions = arrayToSearch
    }
    
    func sendSuggestionToTextField(_ string: String) {
        
        let stringForTextField = NSMutableAttributedString(string: string)
        self.attributedText = stringForTextField
        
        //Set Caret to the end of TextField string
        if let newPosition = self.position(from: self.beginningOfDocument, offset: string.count) {
            self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
    }
    
    //MARK: TextField Button
    @objc fileprivate func handleAddFruitFromTextField() {
        print("Do nothing")
    }

}



