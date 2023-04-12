//
//  MainViewController.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/7/23.
//

import UIKit
import NestedCollectionView

class MainViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var collectionView: NestedCollectionView! {
        didSet {
            collectionView.delegate = self
            
            collectionView.register(UINib(nibName: "MainCellView", bundle: nil), forCellWithReuseIdentifier: MainCellView.cellIdentifier)
            collectionView.register(UINib(nibName: "SliderCellView", bundle: nil), forCellWithReuseIdentifier: SliderCellView.cellIdentifier)
            collectionView.register(UINib(nibName: "HeaderCellView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCellView.cellIdentifier)
        }
    }
    
    // MARK: - Properties -
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        viewModel.delegate = self
        viewModel.getAllSliderAndMovies()
    }
}

// MARK: - MainViewModel Delegate -
extension MainViewController: MainViewModelDelegate {
    func didReloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - NestedCollectionViewDelegate Delegate -
extension MainViewController: NestedCollectionViewDelegate {
    func numberOfSections(in collectionView: NestedCollectionView) -> Int {
        return viewModel.allCategorysList.count
    }
    
    func collectionView(_ collectionView: NestedCollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.allCategorysList[section].isBanner {
            return 1
        }
        
        return viewModel.allCategorysList[section].moviesList.count
    }
    
    func collectionView(_ collectionView: NestedCollectionView, reuseIdentifierForCellAt indexPath: IndexPath) -> String {
        if viewModel.allCategorysList[indexPath.section].isSlider {
            return SliderCellView.cellIdentifier
        }
        
        return MainCellView.cellIdentifier
    }
    
    func collectionView(_ collectionView: NestedCollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SliderCellView {
            // Slider Section
            cell.imgSlider.image = UIImage(named: viewModel.allCategorysList[indexPath.section].moviesList[indexPath.item].imageName)
        } else if let cell = cell as? MainCellView {
            if viewModel.allCategorysList[indexPath.section].isBanner {
                cell.imgPhoto.layer.cornerRadius = 0
                cell.imgPhoto.image = UIImage(named: viewModel.allCategorysList[indexPath.section].bannerImageName)
            } else  {
                cell.imgPhoto.image = UIImage(named: viewModel.allCategorysList[indexPath.section].moviesList[indexPath.item].imageName)
            }
        }
    }
    
    func collectionView(_ collectionView: NestedCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        let width = collectionView.frame.width
        if viewModel.allCategorysList[indexPath.section].isSlider {
            let height = 12 * width / 21
            size = CGSize(width: width, height: height)
        } else if viewModel.allCategorysList[indexPath.section].isBanner {
            size = CGSize(width: width, height: width * 0.2)
        }
        else {
            size = CGSize(width: 160, height: 240)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: NestedCollectionView, insetForSectionAt section: Int) -> UIEdgeInsets {
        if viewModel.allCategorysList[section].isBanner {
            return .zero
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    
    func collectionView(_ collectionView: NestedCollectionView, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if viewModel.allCategorysList[section].isSlider || viewModel.allCategorysList[section].isBanner {
            return .zero
        }
       
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: NestedCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCellView.cellIdentifier, for: indexPath) as! HeaderCellView
            headerView.label.text = viewModel.allCategorysList[indexPath.section].title
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: NestedCollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.allCategorysList[indexPath.section].isBanner {
            guard let url = URL(string: "https://www.devcrew.io"), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    func collectionView(_ collectionView: NestedCollectionView, shouldEnablePagingAt section: Int) -> Bool {
        return viewModel.allCategorysList[section].isSlider
    }
}

