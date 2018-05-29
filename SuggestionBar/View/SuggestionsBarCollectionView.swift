//
//  SuggestionsBar.swift
//  SuggestionBar
//
//  Created by Ricardo V Del Frari on 28/05/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class SuggestionsBarCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    var arrayOfItem = [String]()
    
    @objc dynamic var selectedSuggestion = String()
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
    }
    
    //MARK: Update Suggestions Bar
    func updateSuggestionBarWith(suggestions: [String]) {
        arrayOfItem = suggestions
        self.reloadData()
        if arrayOfItem.count > 0 {
            let selectedIndexPath = NSIndexPath(item: 0, section: 0)
            self.selectItem(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
        }
    }
    
    //MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SuggestionsBarViewCell
        
        cell.suggestionLabel.text = arrayOfItem[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Adapts the cell size based on the string size of the suggetions
        let size = CGSize(width: 1000, height: 44)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: arrayOfItem[indexPath.row]).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)], context: nil)
        
        return CGSize(width: estimatedRect.size.width+16, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        if let suggestionCell = cell as? SuggestionsBarViewCell {
            selectedSuggestion = suggestionCell.suggestionLabel.text!
        }
    }
}





