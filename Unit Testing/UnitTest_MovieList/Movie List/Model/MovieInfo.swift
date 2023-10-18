//
//  MovieInfo.swift
//  Movie List
//

import Foundation
import UIKit

struct MovieInfo: Decodable {
    let results: [MovieResult]
}

struct MovieResult: Decodable {
    let id: Int?
    let posterPath: String?
    var posterUrl: URL?
    let title: String?
    let overview: String?
    var cellHeight: CGFloat?
    var isAddedOnCart: Bool?
    var duration: Int?

    enum CodingKeys: String, CodingKey {
        case id, posterUrl, title, overview, cellHeight, isAddedOnCart, duration
        case posterPath = "poster_path"
    }
}
