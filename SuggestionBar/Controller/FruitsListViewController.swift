//
//  ViewController.swift
//  SuggestionBar
//
//  Created by Ricardo V Del Frari on 28/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class FruitsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var fruitsListTableView: UITableView!
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var fruitsImputTextField: FruitsImputTextField!
    @IBOutlet weak var suggestionBar: SuggestionsBarCollectionView!
    
    let filtederSuggestionsKeyPath = #keyPath(FruitsImputTextField.filteredSuggestions)
    let selectedSuggestionKeyPath = #keyPath(SuggestionsBarCollectionView.selectedSuggestion)

    var zeroHeightConstraint : NSLayoutConstraint!
    var shouldShowSuggestionBar = false

    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Prevent TableView from showing empty rows
        fruitsListTableView.tableFooterView = UIView(frame: .zero)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
        
        fruitsImputTextField.addObserver(self, forKeyPath: filtederSuggestionsKeyPath, options: NSKeyValueObservingOptions.new, context: nil)
        
        suggestionBar.addObserver(self, forKeyPath: selectedSuggestionKeyPath, options: NSKeyValueObservingOptions.new, context: nil)
        
        showSuggestionBar()
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Manager.shared.fruitSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FruitsTableViewCell
        
        let fruit = Manager.shared.fruitSuggestions[indexPath.row]
        
        cell.fruitEmojiLabel.text = fruit.emoji
        cell.fruitNameLabel.text = fruit.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        fruitsImputTextField.resignFirstResponder()
    }
    
    //MARK: Keyboard Methods
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            toolBarBottomConstraint.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                
            }) { (true) in
                
                if isKeyboardShowing {
                    let indexPath = NSIndexPath(row: Manager.shared.fruitSuggestions.count - 1, section: 0)
                    self.fruitsListTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
                }
            }
        }
    }
    
    //MARK: Observers
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == filtederSuggestionsKeyPath {
            if let newValue = change?[.newKey] {
                suggestionBar.updateSuggestionBarWith(suggestions: newValue as! [String])
                shouldShowSuggestionBar = newValue as! [String] == [] ? false : true
                showSuggestionBar()
            }
        }else if keyPath == selectedSuggestionKeyPath {
            if let newValue = change?[.newKey] {
                fruitsImputTextField.sendSuggestionToTextField(newValue as! String)
            }
        }
    }
    
    //MARK: Suggestion Bar Methods
    func showSuggestionBar() {
        
        if zeroHeightConstraint == nil {
            zeroHeightConstraint = suggestionBar.heightAnchor.constraint(equalToConstant: 0)
        }
        
        if shouldShowSuggestionBar {
            zeroHeightConstraint.isActive = false
            shouldShowSuggestionBar = false
        }else {
            zeroHeightConstraint.isActive = true
            shouldShowSuggestionBar = true
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
        self.handleKeyboardNotification(notification: NSNotification(name: NSNotification.Name.UIKeyboardWillShow, object: nil))
        let indexPath = NSIndexPath(row: Manager.shared.fruitSuggestions.count - 1, section: 0)
        self.fruitsListTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }
}

