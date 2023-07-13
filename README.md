# Nested-Collection-View

[![license](https://img.shields.io/badge/license-MIT-green)](https://github.com/DevCrew-io/Nested-Collection-View/blob/main/LICENSE)
![](https://img.shields.io/badge/Code-Swift-informational?style=flat&logo=swift&color=FFA500)
[![Github tag](https://img.shields.io/github/v/tag/DevCrew-io/Nested-Collection-View.svg)]()


This is a multi-level scrolling view with horizontal scrollable items in a vertical scroll. It supports multiple vertical sections, each with its own set of horizontally scrollable items. Built using Swift and UICollectionView, this view provides an intuitive and interactive way to showcase content with a rich and engaging user interface.

![Demo](https://github.com/DevCrew-io/Nested-Collection-View/blob/main/Media/NestedCollectionView-Example.gif)

## Requirements

Nested Collection View requires Xcode 12 or later and is compatible with iOS 11 or later.

Nested Collection View not depends on any third-party libraries

Nested Collection View has no other requirements or dependencies, and can be easily integrated into your existing Xcode project.


## Installation

#### CocoaPods (iOS 8+, OS X 10.9+)

You can use [CocoaPods](http://cocoapods.org/) to install `NestedCollectionView` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod 'NestedCollectionView', '~> 1.0.2'
end
```

#### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `NestedCollectionView` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/DevCrew-io/Nested-Collection-View.git", from: "1.0.2"),
    ]
)
```

### Manually
If you prefer not to use any of the aforementioned dependency managers, you can integrate **NestedCollectionView** into your project manually.

1. Download zip file
2. Open NestedCollectionView/Sources/
3. Drag and drop NestedCollectionView folder into your project


## Usage

###  With Stroyboard 

To use Nested Collection View, first create a NestedCollectionView Outlet:

```swift
import NestedCollectionView

    @IBOutlet weak var collectionView: NestedCollectionView! {
        didSet {
            collectionView.dataSource = self
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
And that's it! Now you can use the follwoing datasourcee & delegate method to setup a collection view just like a normal collection view datasouce & delegate methods.

```swift
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
```

## Author
[DevCrew.IO](https://devcrew.io/)

If you have any questions or comments about **NestedCollectionView** , please feel free to contact us at hello@devcrew.io

<h3 align="left">Connect with Us:</h3>
<p align="left">
<a href="https://devcrew.io" target="blank"><img align="center" src="https://devcrew.io/wp-content/uploads/2022/09/logo.svg" alt="devcrew.io" height="35" width="35" /></a>
<a href="https://www.linkedin.com/company/devcrew-io/mycompany/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="mycompany" height="30" width="40" /></a>
<a href="https://github.com/DevCrew-io" target="blank"><img align="center" src="https://cdn-icons-png.flaticon.com/512/733/733553.png" alt="DevCrew-io" height="32" width="32" /></a>
</p>


## Contributing 
Contributions, issues, and feature requests are welcome! See [Contributors](https://github.com/DevCrew-io/Nested-Collection-View/graphs/contributors) for details.

### Contributions
Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

### Show your Support
Give a star if this project helped you.

### Copyright & License
Code copyright 2023 DevCrew I/O. Code released under the [MIT license](https://github.com/DevCrew-io/Nested-Collection-View/blob/main/LICENSE)
