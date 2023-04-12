//
//  MainViewModel.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/11/23.
//

import Foundation

protocol MainViewModelDelegate {
    func didReloadCollectionView()
}

class MainViewModel {
    
    // MARK: - Properties
    var delegate: MainViewModelDelegate?
    private (set) var allCategorysList: [MainModel] = []

    func getAllSliderAndMovies() {
        var slidersList: [MovieModel] = []
        for sliderIndex in 1..<5 {
            let slider = MovieModel(id: sliderIndex, imageName: "slider-\(sliderIndex)")
            slidersList.append(slider)
        }
        
        allCategorysList.append(MainModel(isSlider: true, movies: slidersList))
        allCategorysList.append(MainModel(title: "Action Movies", movies: getRandom10MoviesList()))
        allCategorysList.append(MainModel(title: "Drama Movies", movies: getRandom10MoviesList()))
        allCategorysList.append(MainModel(title: "Thriller Movies", movies: getRandom10MoviesList()))
        allCategorysList.append(MainModel(title: "Fantasy Movies", movies: getRandom10MoviesList()))
        allCategorysList.append(MainModel(isBanner: true, imageName: "devcrew"))

        delegate?.didReloadCollectionView()
    }
    
    private func getRandom10MoviesList() -> [MovieModel] {
        var moviesList: [MovieModel] = []
        for _ in 0..<10 {
            let randonIndex = Int.random(in: 1..<15)
            let movie = MovieModel(id: randonIndex, imageName: "img-\(randonIndex)")
            moviesList.append(movie)
        }
        
        return moviesList
    }
}
