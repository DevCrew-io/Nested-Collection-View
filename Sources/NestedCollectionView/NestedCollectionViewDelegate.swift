//
//  File.swift
//  
//
//  Created by Najam us Saqib on 4/27/23.
//

import UIKit
import Foundation

// MARK: - NestedCollectionViewDelegate -


/**
 A protocol that provides methods to receive events and perform actions for a nested collection view.

 Conforming to this protocol allows you to define custom behavior for a nested collection view in your application.
 */
@objc public protocol NestedCollectionViewDelegate: NestedCollectionViewDelegateFlowLayout {
    /**
     Tells the delegate that the specified cell is about to be displayed in the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view object that is displaying the cell.
        - cell: The cell that is about to be displayed.
        - indexPath: The index path of the cell.
     
     This method is called just before the cell is displayed in the nested collection view. You can use this method to perform any custom actions on the cell before it is displayed.
     */
    func collectionView(_ collectionView: NestedCollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    
    /**
     Asks the delegate for a view object to display in the specified supplementary view of the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view object requesting the view.
        - kind: The kind of supplementary view to provide.
        - indexPath: The index path that specifies the location of the supplementary view.
     
     - Returns: A configured reusable view object. You must not return `nil` from this method.
     
     This method is called by the nested collection view when it needs to display a supplementary view. You can use this method to provide a custom view object for the supplementary view. You must return a valid reusable view object or your application will crash.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    
    /**
     Tells the delegate that the specified item was selected in the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view object that originated the event.
        - indexPath: The index path of the selected item.
     
     You can use this method to perform any custom actions when an item is selected in the nested collection view.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, didSelectItemAt indexPath: IndexPath)
    
    
    /**
     Tells the delegate that the nested collection view was scrolled horizontally to the specified offset.
     
     - Parameters:
        - collectionView: The nested collection view object that was scrolled.
        - offset: The point at which scrolling stopped.
        - section: The index of the section in which the scrolling occurred.
     
     You can use this method to perform any custom actions when the nested collection view is scrolled horizontally.
     */
    @objc optional func collectionViewDidScrollHorizontally(_ collectionView: NestedCollectionView, toOffset offset: CGPoint, inSection section: Int)
    
    
    /**
     Tells the delegate that the nested collection view was scrolled vertically to the specified offset.
     
     - Parameters:
        - collectionView: The nested collection view object that was scrolled.
        - offset: The point at which scrolling stopped.
     
     You can use this method to perform any custom actions when the nested collection view is scrolled vertically.
     */
    @objc optional func collectionViewDidScrollVertically(_ collectionView: NestedCollectionView, toOffset offset: CGPoint)
    
    
    /**
     Tells the delegate when the user finishes dragging the content view in the horizontal direction.
     
     - Parameters:
        - collectionView: The collection view object that is calling the method.
        - velocity: The velocity of the content view when the user lifts their finger.
        - targetContentOffset: The point at which to stop scrolling.
        - section: The index of the section containing the collection view.
     
     You can use this method to perform any custom actions when the user finishes dragging the content view in the horizontal direction.
     */
    @objc optional func collectionViewWillEndDraggingHorizontally(_ collectionView: NestedCollectionView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, section: Int)
    
    
    /**
     Tells the delegate when the user finishes dragging the content view in the vertical direction.
     
     - Parameters:
        - collectionView: The collection view object that is calling the method.
        - velocity: The velocity of the content view when the user lifts their finger.
        - targetContentOffset: The point at which to stop scrolling.
     
     You can use this method to perform any custom actions when the user finishes dragging the content view in the vertical direction.
     */
    @objc optional func collectionViewWillEndDraggingVertically(_ collectionView: NestedCollectionView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}


// MARK: - NestedCollectionViewDelegateFlowLayout -
/**
 This protocol defines methods that a nested collection view's delegate can implement to provide layout information for the collection view.
 
 The methods in this protocol allow the delegate to provide information about the size and spacing of cells and supplementary views in the collection view. Adopt this protocol in the class that serves as the delegate for the nested collection view.
 */
@objc public protocol NestedCollectionViewDelegateFlowLayout: AnyObject {
    
    /**
     Asks the delegate for the size of the specified item in the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - indexPath: The index path of the item.
     
     - Returns: The size of the item at the specified index path. If you do not implement this method, the collection view uses the default size provided by its layout object.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    
    /**
     Asks the delegate for the inset of the specified section in the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: The inset of the specified section. If you do not implement this method, the collection view uses the default inset provided by its layout object.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, insetForSectionAt section: Int) -> UIEdgeInsets
    
    
    /**
     Asks the delegate for the minimum spacing between lines of items in the specified section of the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: The minimum spacing between lines of items in the specified section. If you do not implement this method, the collection view uses the default spacing provided by its layout object.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    
    /**
     Asks the delegate for the size of the header view in the specified section of the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: The size of the header view in the specified section. If you do not implement this method, the collection view uses the default size provided by its layout object.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    
    /**
     Asks the delegate for the size of the footer view in the specified section of the nested collection view.
     
     - Parameters:
        - collectionView: The nested collection view requesting this information.
        - section: An index number identifying the section.
     
     - Returns: The size of the footer view in the specified section. If you do not implement this method, the collection view uses the default size provided by its layout object.
     */
    @objc optional func collectionView(_ collectionView: NestedCollectionView, referenceSizeForFooterInSection section: Int) -> CGSize
}
