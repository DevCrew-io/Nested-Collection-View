//
//  NestedCollectionViewDataSource.swift
//  
//
//  Created by Najam us Saqib on 4/27/23.
//

import Foundation

// MARK: - NestedCollectionViewDataSource -
/**
 This protocol defines methods that a nested collection view's data source must implement to provide data for the collection view.
 
 The methods in this protocol are responsible for providing information such as the number of items and sections in the collection view, as well as the content for each cell in the collection view.
 
 Adopt this protocol in the class that serves as the data source for the nested collection view. Implement all required methods to provide the necessary data for the collection view to display.
 */
@objc public protocol NestedCollectionViewDataSource: AnyObject {
    
    /**
     Asks the data source to return the number of sections in the nested collection view.
     
     - Parameter collectionView: The nested collection view requesting this information.
     
     - Returns: The number of sections in the nested collection view.
     */
    func numberOfSections(in collectionView: NestedCollectionView) -> Int
    
    
    /**
     Asks the data source to return the number of items in the specified section of the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: The number of items in the specified section of the nested collection view.
     */
    func collectionView(_ collectionView: NestedCollectionView, numberOfItemsInSection section: Int) -> Int
    
    
    /**
     Asks the data source for a reusable cell identifier to use when creating a cell for the item at the specified index path.
     
     - Parameter indexPath: The index path that specifies the location of the item.
     
     - Returns: A string identifying the reusable cell.
     
     - Note: You should use the same reuse identifier for all cells of the same class.
     */
    func collectionView(_ collectionView: NestedCollectionView, reuseIdentifierForCellAt indexPath: IndexPath) -> String
    
    
    #if os(iOS)
    /**
     Asks the data source to enable or disable paging for the nested collection view in the specified section.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: `true` if paging is enabled for the nested collection view in the specified section; otherwise, `false`.
     
     - Note: This method is optional and only available on iOS.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, shouldEnablePagingAt section: Int) -> Bool
    #endif
}
