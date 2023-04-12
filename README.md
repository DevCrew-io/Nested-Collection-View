# Nested-Collection-View

![Demo](https://github.com/DevCrew-io/Nested-Collection-View/blob/main/Media/NestedCollectionView-Example.gif)

## What is it?

This is a multi-level scrolling view with horizontal scrollable items in a vertical scroll. It supports multiple vertical sections, each with its own set of horizontally scrollable items. Built using Swift and UICollectionView, this view provides an intuitive and interactive way to showcase content with a rich and engaging user interface.


## Requirements

Nested Collection View requires Xcode 12 or later and is compatible with iOS 11 or later.

Nested Collection View not depends on any third-party libraries

Nested Collection View has no other requirements or dependencies, and can be easily integrated into your existing Xcode project.


## Installation

#### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `NestedCollectionView` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/DevCrew-io/Nested-Collection-View", from: "1.0.0"),
    ]
)
```

## Usage

###  With Stroyboard 

To use Nested Collection View, first create a NestedCollectionView Outlet:

```swift
import NestedCollectionView

    @IBOutlet weak var collectionView: NestedCollectionView! {
        didSet {
            collectionView.delegate = self
            
            collectionView.register(UINib(nibName: "MainCellView", bundle: nil), forCellWithReuseIdentifier: MainCellView.cellIdentifier)
            collectionView.register(UINib(nibName: "SliderCellView", bundle: nil), forCellWithReuseIdentifier: SliderCellView.cellIdentifier)
            collectionView.register(UINib(nibName: "HeaderCellView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCellView.cellIdentifier)
        }
    }
```

###  Without Storyboard

To use Nested Collection View, first create a NestedCollectionView Instance:

```swift
import NestedCollectionView

let nestedCollectionView = NestedCollectionView(frame: CGRect.zero)
```

Then add your nested collection view delegate:

```swift
    collectionView.delegate = self
```

Finally, add the nested collection view to your view hierarchy:

```swift
view.addSubview(nestedCollectionView)
```
And that's it! Now you can use the follwoing delegate method to setup a collection view just like a normal collection view datasouce & delegate methods.

```swift
@objc public protocol NestedCollectionViewDelegate: AnyObject {
    func numberOfSections(in collectionView: NestedCollectionView) -> Int
    func collectionView(_ collectionView: NestedCollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: NestedCollectionView, reuseIdentifierForCellAt indexPath: IndexPath) -> String
    func collectionView(_ collectionView: NestedCollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: NestedCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func collectionView(_ collectionView: NestedCollectionView, insetForSectionAt section: Int) -> UIEdgeInsets
    @objc optional func collectionView(_ collectionView: NestedCollectionView, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func collectionView(_ collectionView: NestedCollectionView, referenceSizeForHeaderInSection section: Int) -> CGSize
    @objc optional func collectionView(_ collectionView: NestedCollectionView, referenceSizeForFooterInSection section: Int) -> CGSize
    @objc optional func collectionView(_ collectionView: NestedCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    @objc optional func collectionView(_ collectionView: NestedCollectionView, didSelectItemAt indexPath: IndexPath)
    
    #if os(iOS)
    @objc optional func collectionView(_ collectionView: NestedCollectionView, shouldEnablePagingAt section: Int) -> Bool
    #endif
    
    @objc optional func collectionViewDidScrollHorizontally(_ collectionView: NestedCollectionView, toOffset offset: CGPoint, inSection section: Int)
    @objc optional func collectionViewDidScrollVertically(_ collectionView: NestedCollectionView, toOffset offset: CGPoint)
    
    @objc optional func collectionViewWillEndDraggingHorizontally(_ collectionView: NestedCollectionView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, section: Int)
    @objc optional func collectionViewWillEndDraggingVertically(_ collectionView: NestedCollectionView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}
```

## Contributions

Contributions to Nested Collection View are always welcome! See [Contributors](https://github.com/DevCrew-io/Nested-Collection-View/graphs/contributors) for details.

## Contact

If you have any questions or comments about Nested Collection View, please feel free to contact us at info@devcrew.io.

## Acknowledgments

Nested Collection View was created by the DevCrew.io team.
