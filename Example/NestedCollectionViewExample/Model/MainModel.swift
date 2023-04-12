//
//  MainModel.swift
//  NestedCollectionViewExample
//
//  Created by Najam us Saqib on 4/11/23.
//

import Foundation

class MainModel {
    var title: String = ""
    var isSlider: Bool = false
    var isBanner:Bool = false
    var bannerImageName: String = ""
    var moviesList: [MovieModel] = []
    
    init(title: String, movies: [MovieModel]) {
        self.title = title
        self.moviesList = movies
    }
    
    init(isSlider: Bool, movies: [MovieModel]) {
        self.isSlider = isSlider
        self.moviesList = movies
    }
    
    init(isBanner: Bool, imageName: String) {
        self.isBanner = isBanner
        self.bannerImageName = imageName
    }
}
