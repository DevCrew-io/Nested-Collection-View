//
//  NestedCollectionView.swift
//
//  Created by Najam Us Saqib on 4/7/23.
//

import UIKit

public class NestedCollectionView: UIView {
    
    public weak var dataSource: NestedCollectionViewDataSource?
    public weak var delegate: NestedCollectionViewDelegate?

    private var outerCollectionView: UICollectionView!
    private let collectionViewCellIndentifier = String(describing: OuterCollectionViewCell.self)
    private var cellClassesReuseRegistry: [String: AnyClass?] = [:]
    private var cellNibsReuseRegistry: [String: UINib?] = [:]
    private var sectionsOffset: [Int: CGPoint] = [:]
    
    private var lastSelectedIndexPath: IndexPath?
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        outerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        outerCollectionView.clipsToBounds = false
        outerCollectionView.backgroundColor = .clear
        outerCollectionView.showsVerticalScrollIndicator = false
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
        addSubview(outerCollectionView)
        
        outerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerCollectionView.topAnchor.constraint(equalTo: topAnchor),
            outerCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            outerCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            outerCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        outerCollectionView.register(OuterCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIndentifier)
    }
    
    // MARK: - UICollectionView Public Methods -
    
    /// Registers a class for use in creating new collection view cells.
    ///
    /// - Parameters:
    ///   - cellClass: The class of the cell to register. This class must be a subclass of `UICollectionViewCell`.
    ///   - identifier: A string that identifies the reuse identifier to associate with the specified class. This parameter must not be `nil`.
    ///
    /// You must register a class or nib file using this method before calling the `dequeueReusableCell(withReuseIdentifier:for:)` method to create a new cell. If a class or nib file with the same reuse identifier has already been registered, this method replaces the previously registered class or nib file with the new one.
    ///
    /// The reuse identifier is used to identify the cell when it is dequeued using the `dequeueReusableCell(withReuseIdentifier:for:)` method. If you do not specify a reuse identifier when registering the cell, a default reuse identifier is used, which is the class name of the cell.
    public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        cellClassesReuseRegistry[identifier] = cellClass
    }
    
    /// Registers a nib file for use in creating new collection view cells.
    ///
    /// - Parameters:
    ///   - nib: The nib file containing the cell to register. This nib file must contain exactly one top-level object which is a `UICollectionViewCell` instance.
    ///   - identifier: A string that identifies the reuse identifier to associate with the specified nib file. This parameter must not be `nil`.
    ///
    /// You must register a nib file or class using this method before calling the `dequeueReusableCell(withReuseIdentifier:for:)` method to create a new cell. If a nib file or class with the same reuse identifier has already been registered, this method replaces the previously registered nib file or class with the new one.
    ///
    /// The reuse identifier is used to identify the cell when it is dequeued using the `dequeueReusableCell(withReuseIdentifier:for:)` method. If you do not specify a reuse identifier when registering the cell, a default reuse identifier is used, which is the class name of the cell.
    ///
    /// The nib file must contain exactly one top-level object which is a `UICollectionViewCell` instance. This cell is used as the prototype for new cells when they are created. If the nib file contains multiple top-level objects, or no `UICollectionViewCell` instance, an exception is raised at runtime.
    public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        cellNibsReuseRegistry[identifier] = nib
    }
    
    /// Registers a class for use in creating new supplementary views for the collection view.
    ///
    /// - Parameters:
    ///   - viewClass: The class of the supplementary view to register. This class must be a subclass of `UICollectionReusableView`.
    ///   - elementKind: A string that identifies the kind of supplementary view to create. This string must not be `nil`.
    ///   - identifier: A string that identifies the reuse identifier to associate with the specified class. This parameter must not be `nil`.
    ///
    /// You must register a class or nib file using this method before calling the `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` method to create a new supplementary view. If a class or nib file with the same reuse identifier has already been registered for the same kind of supplementary view, this method replaces the previously registered class or nib file with the new one.
    ///
    /// The reuse identifier is used to identify the supplementary view when it is dequeued using the `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` method. If you do not specify a reuse identifier when registering the supplementary view, a default reuse identifier is used, which is the class name of the view.
    public func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) {
        outerCollectionView.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /// Registers a nib object containing a supplementary view with the collection view.
    ///
    /// - Parameters:
    ///   - nib: The nib object containing the supplementary view object. This parameter must not be `nil`.
    ///   - kind: A string that identifies the kind of supplementary view to create. This string must not be `nil`.
    ///   - identifier: A string that identifies the reuse identifier to associate with the specified nib file. This parameter must not be `nil`.
    ///
    /// You must register a nib file or class using this method before calling the `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` method to create a new supplementary view. If a nib file or class with the same reuse identifier has already been registered for the same kind of supplementary view, this method replaces the previously registered nib file or class with the new one.
    ///
    /// The reuse identifier is used to identify the supplementary view when it is dequeued using the `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` method. If you do not specify a reuse identifier when registering the nib file, a default reuse identifier is used, which is the nib file name.
    public func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String) {
        outerCollectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    /// Returns a reusable supplementary view of the specified kind and reuse identifier.
    ///
    /// - Parameters:
    ///   - elementKind: A string that identifies the kind of supplementary view to retrieve. This parameter must not be `nil`.
    ///   - identifier: A string identifying the reuse identifier for the supplementary view. This parameter must not be `nil`.
    ///   - indexPath: The index path specifying the location of the supplementary view in the collection view. The value of this parameter must not be `nil`.
    ///
    /// Call this method from your data source object when asked to provide a new supplementary view for the collection view. This method dequeues an existing supplementary view if one is available or creates a new one using the class or nib file you registered. The reuse identifier you specify must match the identifier for a previously registered supplementary view, either by calling the `register(_:forSupplementaryViewOfKind:withReuseIdentifier:)` method or by assigning it in your storyboard file.
    ///
    /// - Returns: A reusable supplementary view of the specified kind and reuse identifier. If no such view is available for reuse, this method returns `nil`.
    public func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        return outerCollectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: indexPath)
    }
    
    /// Reloads all of the data for the collection view.
    ///
    /// Call this method to reload all of the items and supplementary views in the collection view. This method discards any currently visible views and recreates all of the views from the layout information provided by your data source and layout delegate objects. You should not call this method in the middle of animation blocks or with other calls to reload data, as it may cause visual glitches in the collection view.
    public func reloadData() {
        outerCollectionView.reloadData()
    }
    
    /// Reloads the data in the specified sections of the collection view.
    ///
    /// Call this method to reload the items and supplementary views in one or more sections of the collection view. This method discards any currently visible views in the specified sections and recreates all of the views from the layout information provided by your data source and layout delegate objects. You should not call this method in the middle of animation blocks or with other calls to reload data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter sections: An index set containing the indexes of the sections to reload.
    public func reloadSections(_ sections: IndexSet) {
        outerCollectionView.reloadSections(sections)
    }
    
    /// Reloads the data for the items at the specified index paths.
    ///
    /// Call this method to reload one or more items in the collection view. This method discards any currently visible views for the specified items and recreates all of the views from the layout information provided by your data source and layout delegate objects. You should not call this method in the middle of animation blocks or with other calls to reload data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter indexPaths: An array of index paths identifying the items to reload.
    public func reloadItems(at indexPaths: [IndexPath]) {
        outerCollectionView.reloadItems(at: indexPaths)
    }
    
    /// Inserts one or more new sections into the collection view.
    ///
    /// Call this method to insert new sections into the collection view. You should also update your data source and layout delegate to reflect the new sections. The collection view animates the insertion of the new sections and adjusts the layout of any existing sections as needed. You should not call this method in the middle of animation blocks or with other calls to insert or delete data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter sections: An index set containing the indexes of the sections to insert.
    public func insertSections(_ sections: IndexSet) {
        outerCollectionView.insertSections(sections)
    }
    
    /// Inserts one or more new items into the collection view.
    ///
    /// Call this method to insert new items into the collection view. You should also update your data source and layout delegate to reflect the new items. The collection view animates the insertion of the new items and adjusts the layout of any existing items as needed. You should not call this method in the middle of animation blocks or with other calls to insert or delete data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter indexPaths: An array of index paths identifying the items to insert.
    public func insertItems(at indexPaths: [IndexPath]) {
        outerCollectionView.insertItems(at: indexPaths)
    }
    
    /// Deletes one or more sections from the collection view.
    ///
    /// Call this method to delete sections from the collection view. You should also update your data source and layout delegate to reflect the deleted sections. The collection view animates the deletion of the sections and adjusts the layout of any remaining sections as needed. You should not call this method in the middle of animation blocks or with other calls to insert or delete data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter sections: An index set containing the indexes of the sections to delete.
    public func deleteSections(_ sections: IndexSet) {
        outerCollectionView.deleteSections(sections)
    }
    
    /// Deletes one or more items from the collection view.
    ///
    /// Call this method to delete items from the collection view. You should also update your data source and layout delegate to reflect the deleted items. The collection view animates the deletion of the items and adjusts the layout of any remaining items as needed. You should not call this method in the middle of animation blocks or with other calls to insert or delete data, as it may cause visual glitches in the collection view.
    ///
    /// - Parameter indexPaths: An array of index paths identifying the items to delete.
    public func deleteItems(at indexPaths: [IndexPath]) {
        outerCollectionView.deleteItems(at: indexPaths)
    }
    
    /// The distance that the content view is inset from the enclosing scroll view.
    ///
    /// Use this property to add padding around the content view in the scroll view. The inset values are applied to the scroll view's content area, which is the area that can be scrolled. Setting this property adjusts the scroll view's `contentSize` property to account for the inset.
    ///
    /// The default value of this property is `UIEdgeInsets.zero`, which means that there is no additional padding around the content view.
    public var contentInset: UIEdgeInsets {
        get {
            return outerCollectionView.contentInset
        }
        set {
            outerCollectionView.contentInset = newValue
        }
    }

    /// The point at which the origin of the content view is offset from the origin of the scroll view.
    ///
    /// This property specifies the offset of the scroll view's content view relative to its origin. The default value is `CGPoint.zero`. Changing the value of this property updates the position of the scroll view's content in the visible area. You can use this property to implement custom scrolling behavior, such as parallax effects or infinite scrolling.
    public var contentOffset: CGPoint {
        get {
            return outerCollectionView.contentOffset
        }
        set {
            outerCollectionView.contentOffset = newValue
        }
    }
    
    /// The behavior to use when adjusting the scroll view's content insets.
    ///
    /// Use this property to specify how the collection view adjusts its content insets in response to changes in its environment, such as a navigation bar or tab bar. The default value of this property is `.automatic`, which means that the collection view adjusts its insets based on the scroll view's safe area insets. Changing the value of this property updates the layout of the collection view, adjusting the positions of the cells, supplementary views, and decorations.
    public var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {
        get {
            return outerCollectionView.contentInsetAdjustmentBehavior
        }
        set {
            outerCollectionView.contentInsetAdjustmentBehavior = newValue
        }
    }
    
    /// The layout object used to organize the collection view's items and supplementary views.
    ///
    /// Use this property to get or set the layout object for the collection view. You can use one of the built-in layout classes provided by UIKit, such as `UICollectionViewFlowLayout`, or create your own custom layout object by subclassing `UICollectionViewLayout`.
    ///
    /// To customize the behavior of the layout object, configure its properties before assigning it to this property. You can also subclass the layout object and override its methods to implement custom layout behavior. Changing the value of this property updates the layout of the collection view, adjusting the positions of the cells, supplementary views, and decorations.
    public var collectionViewLayout: UICollectionViewLayout {
        get {
            return outerCollectionView.collectionViewLayout
        }
        set {
            outerCollectionView.collectionViewLayout = newValue
        }
    }
    
    /// A Boolean value indicating whether the collection view is currently tracking touches.
    ///
    /// Use this property to determine whether the user is currently interacting with the collection view. When the value of this property is `true`, the collection view is actively tracking touches, which means the user is touching the screen and dragging one or more items or scrolling the content. When the value is `false`, the user is not interacting with the collection view.
    ///
    /// You can use this property to customize the behavior of the collection view based on the user's interaction. For example, you might disable user interaction or update the appearance of the items while the user is dragging or scrolling.
    public var isTracking: Bool {
        return outerCollectionView.isTracking
    }
    
    /// Returns the cell at the specified index path.
    ///
    /// - Parameter indexPath: The index path that specifies the location of the cell.
    /// - Returns: A `UICollectionViewCell` object at the specified index path.
    ///
    /// Use this method to get a reference to a cell in the collection view. You can then configure the cell's content based on the data at the corresponding index path.
    ///
    /// If the cell is not visible, this method returns `nil`. You should only call this method for cells that are currently visible on the screen.
    public func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        guard
            let outerCollectionViewCell = outerCollectionView.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as? OuterCollectionViewCell,
            let innerCollectionView = outerCollectionViewCell.innerCollectionView,
            let cell = innerCollectionView.cellForItem(at: IndexPath(item: indexPath.item, section: 0))
        else {
            return nil
        }
        
        return cell
    }
    
    /// Returns the supplementary view associated with the specified element kind and section.
    ///
    /// - Parameters:
    ///   - elementKind: The kind of supplementary view to retrieve. This value is defined by the layout object.
    ///   - section: The index of the section that contains the supplementary view.
    /// - Returns: A `UICollectionReusableView` object representing the supplementary view or `nil` if no supplementary view is available for the specified parameters.
    ///
    /// This method returns the supplementary view associated with the specified element kind and section. Use this method to retrieve a previously created supplementary view, so you can configure its content based on the data in your data source.
    public func supplementaryView(forElementKind elementKind: String, at section: Int) -> UICollectionReusableView? {
        return outerCollectionView.supplementaryView(forElementKind: elementKind, at: IndexPath(item: 0, section: section))
    }

    ///
    /// Scrolls to the item at the specified index path.
    ///
    ///- Parameters:
    ///   - indexPath: The index path of the item to scroll to.
    ///    - scrollPosition: The position at which to place the item.
    ///   - animated: A Boolean value that indicates whether the scrolling should be animated.
    ///
    ///This method scrolls to the item by first scrolling to the top of the section that contains the item, and then scrolling to the item itself. The `animated` parameter determines whether or not the scrolling is animated.
    ///
    /// If the `indexPath` parameter is not valid, this method has no effect.
    ///
    /// - Note:
    /// This method only works if the collection view's layout is configured to display a single item per row in each section.
    public func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        outerCollectionView.scrollToItem(at: IndexPath(item: 0, section: indexPath.section), at: .top, animated: false)
        outerCollectionView.layoutIfNeeded()
        
        if let outerCollectionViewCell = outerCollectionView.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as? OuterCollectionViewCell {
            outerCollectionViewCell.innerCollectionView.scrollToItem(at: IndexPath(item: indexPath.item, section: 0), at: scrollPosition, animated: animated)
        }
    }
    
    ///
    /// Sets the content offset of the scroll view to the specified point.
    ///
    /// - Parameter contentOffset: A `CGPoint` value representing the new content offset to set.
    /// - Parameter animated: A `Bool` indicating whether the scrolling should be animated or not.
    ///
    public func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        outerCollectionView.setContentOffset(contentOffset, animated: true)
    }
    
    ///
    /// Returns: An array of IndexPath objects representing the currently selected items in the collection view. If there are no selected items, returns nil.
    public var indexPathsForSelectedItems: [IndexPath]? {
        guard let indexPath = lastSelectedIndexPath else {
            return nil
        }
        return [indexPath]
    }
    
}

// MARK: - UIScrollViewDelegate -
extension NestedCollectionView {
    
    ///
    /// This method is called when the scroll view's content offset changes.
    ///
    /// Use this method to perform any additional layout or updates based on the current content offset.
    ///
    /// - Parameter scrollView: The scroll view whose content offset changed.
    ///
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let direction: UICollectionView.ScrollDirection = scrollView == outerCollectionView ? .vertical : .horizontal
        
        if direction == .horizontal {
            let innerCollectionView = scrollView as! InnerCollectionView
            let savedOffset = sectionsOffset[innerCollectionView.section] ?? .zero
            
            if innerCollectionView.isScrollEnabled {
                // Save offset to restore it once the cell gets reused
                sectionsOffset[innerCollectionView.section] = innerCollectionView.contentOffset
            }
            else if !innerCollectionView.contentOffset.equalTo(savedOffset) {
                // Reject new content offset and restore previous one if content offset changes are not allowed.
                innerCollectionView.contentOffset = savedOffset
            }
        }
        
        if let innerCollectionView = scrollView as? InnerCollectionView {
            delegate?.collectionViewDidScrollHorizontally?(self, toOffset: scrollView.contentOffset, inSection: innerCollectionView.section)
        }
        else {
            delegate?.collectionViewDidScrollVertically?(self, toOffset: scrollView.contentOffset)
        }
    }
    
    ///
    /// Called when user has lifted finger off the screen and scroll view is about to stop scrolling.
    /// - Parameters:
    ///   - scrollView: The scroll-view object that is decelerating the scrolling of the content view.
    ///   - velocity: The velocity of the content view when the user lifts their finger.
    ///   - targetContentOffset: The expected offset of the top-left corner of the visible content view when the scrolling stops.
    ///
    /// - Note: This method can be used to adjust the final offset that will be used by the scroll view. For example, you can use this method to snap the content view to a specific position or adjust the scrolling speed.
    ///
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let innerCollectionView = scrollView as? InnerCollectionView {
            delegate?.collectionViewWillEndDraggingHorizontally?(self, withVelocity: velocity, targetContentOffset: targetContentOffset, section: innerCollectionView.section)
        }
        else {
            delegate?.collectionViewWillEndDraggingVertically?(self, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout -
extension NestedCollectionView: UICollectionViewDelegateFlowLayout {
    
    /**
     Returns the size for an item at the specified index path.

     - Parameter collectionView: The collection view object displaying the item.
     - Parameter collectionViewLayout: The layout object requesting the size information.
     - Parameter indexPath: The index path of the item whose size is being requested.
     - Returns: The size of the item at the specified index path.
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        
        if collectionView == outerCollectionView {
            size.width = outerCollectionView.frame.width
            if let contentCellSize = delegate?.collectionView?(self, sizeForItemAt: IndexPath(item: 0, section: indexPath.section)) {
                size.height = contentCellSize.height
            }
        }
        else {
            let innerCollectionView = collectionView as! InnerCollectionView
            if let contentCellSize = delegate?.collectionView?(self, sizeForItemAt: IndexPath(item: indexPath.item, section: innerCollectionView.section)) {
                size = contentCellSize
            }
        }
        
        return size
    }
    
    /**
    Defines the padding of a section in the collection view.

    - Parameters:
       - collectionView: The collection view requesting the information.
       - collectionViewLayout: The layout object requesting the information.
       - section: The index of the section whose insets are being requested.

    - Returns: The `UIEdgeInsets` object representing the top, left, bottom and right margins for the section.
    */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let actualSection = collectionView == outerCollectionView ? section : (collectionView as! InnerCollectionView).section

        if let clientInsets = delegate?.collectionView?(self, insetForSectionAt: actualSection) {
            if collectionView == outerCollectionView {
                insets.top = clientInsets.top
                insets.bottom = clientInsets.bottom
            } else {
                insets.left = clientInsets.left
                insets.right = clientInsets.right
            }
        }

        if dataSource?.collectionView?(self, shouldEnablePagingAt: actualSection) ?? false {
            insets.left = .zero
            insets.right = .zero
        }
        
        return insets
    }
    
    /**
     Returns the minimum line spacing between items in the specified section of the collection view.

     - Parameters:
       - collectionView: The collection view requesting this information.
       - collectionViewLayout: The layout object that is requesting the information.
       - section: The index of the section.

     - Returns: The minimum line spacing for the section.
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var spacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
        guard let innerCollectionView = collectionView as? InnerCollectionView else { return spacing }
        
        if dataSource?.collectionView?(self, shouldEnablePagingAt: innerCollectionView.section) ?? false {
            return .zero
        }
        
        if let minimumSpacing = delegate?.collectionView?(self, minimumLineSpacingForSectionAt: innerCollectionView.section) {
            spacing = minimumSpacing
        }
        
        return spacing
    }
    
    /**
    Returns the size for the header view in the specified section of the collection view.

    - Parameters:
      - collectionView: The collection view requesting this information.
      - collectionViewLayout: The layout object requesting the information.
      - section: The index of the section whose header size is being requested.
     
    - Returns: The size for the header view. Use CGSize.zero for no header. The default value is CGSize.zero.
    */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if
            collectionView == outerCollectionView,
            let size = delegate?.collectionView?(self, referenceSizeForHeaderInSection: section) {
            return size
        }
        
        return .zero
    }
    
    /**
     Returns the size for the footer view in the specified section of the collection view.
     
     - Parameters:
        - collectionView: The collection view object displaying the flow layout.
        - collectionViewLayout: The layout object requesting the information.
        - section: The index of the section whose footer size is being requested.
     
     - Returns: The size of the footer view. Use CGSize.zero for no footer. The default value is CGSize.zero.
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if
            collectionView == outerCollectionView,
            let size = delegate?.collectionView?(self, referenceSizeForFooterInSection: section) {
            return size
        }
        
        return .zero
    }
    
}

// MARK: - UICollectionViewDataSource -
extension NestedCollectionView: UICollectionViewDataSource {
    
    /**
    Returns the number of sections in the collection view.
     
     - Parameter collectionView: The collection view requesting this information.
     - Returns: The number of sections in collectionView.
    */
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == outerCollectionView {
            return dataSource?.numberOfSections(in: self) ?? 0
        }
        
        return 1
    }
    
    /**
    Returns the number of items in the specified section of the collection view.

     - Parameters:
        - collectionView: The collection view requesting this information.
        - section: An index number identifying a section in collectionView.
     
     - Returns: The number of items in section.
     
     - Note: This method is required by the UICollectionViewDataSource protocol.
    */
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == outerCollectionView {
            return 1
        }
        
        let innerCollectionView = collectionView as! InnerCollectionView
        return dataSource?.collectionView(self, numberOfItemsInSection: innerCollectionView.section) ?? 0
    }
    
    /**
    Creates and returns a cell for the specified item at the specified index path in the collection view.

    If the collection view is the outer collection view, it dequeues an OuterCollectionViewCell, configures it, and returns it. If the collection view is an inner collection view, it dequeues the appropriate cell identified by its reuse identifier and returns it. If there is no reuse identifier provided by the delegate, it returns an empty UICollectionViewCell.

    - Parameters:
      - collectionView: The collection view requesting this information.
      - indexPath: The index path that specifies the location of the item.
     
    - Returns: A configured UICollectionViewCell object.
    */
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == outerCollectionView {
            let outerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIndentifier, for: indexPath) as! OuterCollectionViewCell
            outerCollectionViewCell.configure(with: cellClassesReuseRegistry, nibsReuseRegistry: cellNibsReuseRegistry, listener: self)
            outerCollectionViewCell.section = indexPath.section
            outerCollectionViewCell.innerCollectionView.setContentOffset(.zero, animated: false)
            
            #if os(iOS)
            let pagingEnabled = dataSource?.collectionView?(self, shouldEnablePagingAt: indexPath.section) ?? false
            outerCollectionViewCell.innerCollectionView.isPagingEnabled = pagingEnabled
            #endif
            
            let savedOffset = sectionsOffset[indexPath.section]
            if let offset = savedOffset {
                outerCollectionViewCell.innerCollectionView.setContentOffset(offset, animated: false)
            }
            
            outerCollectionViewCell.innerCollectionView.isScrollEnabled = false
            
            outerCollectionViewCell.innerCollectionView.reloadData()
            
            return outerCollectionViewCell
        }
        
        let innerCollectionView = collectionView as! InnerCollectionView
        let innerCollectionViewItemIndex = IndexPath(item: indexPath.item, section: innerCollectionView.section)
        
        if let cellIdentifier = dataSource?.collectionView(self, reuseIdentifierForCellAt: innerCollectionViewItemIndex) {
            let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: innerCollectionViewItemIndex)
            delegate?.collectionView(self, willDisplay: cell, forItemAt: innerCollectionViewItemIndex)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = delegate?.collectionView?(self, viewForSupplementaryElementOfKind: kind, at: indexPath) else {
            return UICollectionReusableView()
        }
        
        return view
    }
    
}

// MARK: - UICollectionViewDelegate -
extension NestedCollectionView: UICollectionViewDelegate {
    
    /**
    This method is called just before a cell is displayed on the screen in the specified collection view. It updates the isScrollEnabled property of innerCollectionView of outerCollectionViewCell to true to enable scrolling.

    - Parameters:
      - collectionView: The collection view requesting this information.
      - cell: The cell that is about to be displayed.
      - indexPath: The index path of the cell.
    */
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let outerCollectionViewCell = cell as? OuterCollectionViewCell {
            outerCollectionViewCell.innerCollectionView.isScrollEnabled = true
        }
    }
    
    /**
    This method is called when an item is selected in the collection view. If the collection view is the `OuterCollectionView`, this method does nothing. If the collection view is an `InnerCollectionView` the last selected index path is updated with the selected item's index path and the delegate method collectionView(_:didSelectItemAt:) is called to notify the delegate of the selection.

     - Parameters:
        - collectionView: The collection view that is notifying about the selection.
        - indexPath: The index path of the selected item.
    */
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != outerCollectionView {
            let innerCollectionView = collectionView as! InnerCollectionView
            lastSelectedIndexPath = IndexPath(item: indexPath.item, section: innerCollectionView.section)
            delegate?.collectionView?(self, didSelectItemAt: IndexPath(item: indexPath.item, section: innerCollectionView.section))
        }
    }
    
    /**
     Notifies the delegate that the specified item was deselected.

     - Parameters:
        - collectionView: The collection view object that is notifying you of the selection change.
        - indexPath: The index path of the item that was deselected.

     This method sets the `lastSelectedIndexPath` property to `nil`.
    */
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        lastSelectedIndexPath = nil
    }
    
    /**
    Determines whether the specified item at the given index path can be focused or not.
    The item can be focused only if the collection view is not the `OuterCollectionView.
     
    - Parameters:
       - collectionView: The collection view object displaying the item.
       - indexPath: The index path of the item.
     
     - Returns: A Boolean value indicating whether the item can be focused.
     */
    public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return collectionView != outerCollectionView
    }
    
}
