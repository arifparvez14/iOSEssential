//
//  Constants.swift
//  Movie List
//

import Foundation
import UIKit

//MARK: URLs
let baseURL: String = "https://api.themoviedb.org/"
let baseImageUrl: String = "https://image.tmdb.org/t/p/original/"

//MARK: API Key/Value
let kApiKeyParam = "api_key"
let kApiKeyValue = "38e61227f85671163c275f9bd95a8803"
let kQueryParam = "query"
let kQueryDefaultValue = "marvel"

//MARK: Strings
let viewTitle = "Movie List"
let tableViewCellName = "MovieTableViewCell"
let defaultThumbnailImageName = "Default_Image_Thumbnail"
let cartTableViewCellName = "CartTableViewCell"
let cartTotalTableViewCellName = "CartTotalTableViewCell"

//MARK: NUMBERS
let posterImageWidth: CGFloat = 120
let timeOutInterval: TimeInterval = 20.0
let defaultCellHeight: CGFloat = 180
let labelFontSize: CGFloat = 17

//MARK: Others
let imageCache = NSCache<AnyObject, UIImage>()

func loadJsonFrom(fileName: String) -> MovieInfo? {
    do {
       if let bundlePath = Bundle.main.path(forResource: "MockMovieResponse", ofType: "json"),
       let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             
          // Decoding the Product type from JSON data using JSONDecoder() class.
          let movieInfo = try JSONDecoder().decode(MovieInfo.self, from: jsonData)
         return movieInfo
       }
    } catch {
       return nil
    }
    return nil
}
