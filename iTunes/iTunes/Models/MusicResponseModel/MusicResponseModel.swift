//
//  MusicResponseModel.swift
//  iTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit
import ObjectMapper

class MusicResponseModel: BaseResponseModel {
    
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case results
    }
    
    // MARK: - Model Variables
    
    var results: [Music]?
    
    // MARK: - Model mapping
    
    public override func mapping(map: Map) {
        super.mapping(map: map)

        results <- map[CodingKeys.results.rawValue]
    }
}

class Music: BaseResponseModel {
    
    // MARK: - Result
    
    var wrapperType: String?
    var kind: String?
    var collectionID, trackID: Int?
    var artistName, collectionName, trackName, collectionCensoredName: String?
    var trackCensoredName: String?
    var collectionViewURL: String?
    var feedURL: String?
    var trackViewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    var collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double?
    var trackHDPrice, trackHDRentalPrice: Double?
    var releaseDate: String?
    var collectionExplicitness, trackExplicitness: String?
    var trackCount: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var contentAdvisoryRating: String?
    var artworkUrl600: String?
    var genreIDS, genres: [String]?
    var artistID: Int?
    var artistViewURL: String?
    
    enum CodingKeys: String {
        case wrapperType, kind
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionViewURL = "collectionViewUrl"
        case feedURL = "feedUrl"
        case trackViewURL = "trackViewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackCount, country, currency, primaryGenreName, contentAdvisoryRating, artworkUrl600
        case genreIDS = "genreIds"
        case genres
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
    }
    
    // MARK: - Model mapping
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        wrapperType <- map[CodingKeys.wrapperType.rawValue]
        kind <- map[CodingKeys.kind.rawValue]
        collectionID <- map[CodingKeys.collectionID.rawValue]
        trackID <- map[CodingKeys.trackID.rawValue]
        artistName <- map[CodingKeys.artistName.rawValue]
        collectionName <- map[CodingKeys.collectionName.rawValue]
        trackName <- map[CodingKeys.trackName.rawValue]
        collectionCensoredName <- map[CodingKeys.collectionCensoredName.rawValue]
        trackCensoredName <- map[CodingKeys.trackCensoredName.rawValue]
        collectionViewURL <- map[CodingKeys.collectionViewURL.rawValue]
        feedURL <- map[CodingKeys.feedURL.rawValue]
        trackViewURL <- map[CodingKeys.trackViewURL.rawValue]
        artworkUrl30 <- map[CodingKeys.artworkUrl30.rawValue]
        artworkUrl60 <- map[CodingKeys.artworkUrl60.rawValue]
        artworkUrl100 <- map[CodingKeys.artworkUrl100.rawValue]
        collectionPrice <- map[CodingKeys.collectionPrice.rawValue]
        trackPrice <- map[CodingKeys.trackPrice.rawValue]
        trackRentalPrice <- map[CodingKeys.trackRentalPrice.rawValue]
        collectionHDPrice <- map[CodingKeys.collectionHDPrice.rawValue]
        trackHDPrice <- map[CodingKeys.trackHDPrice.rawValue]
        trackHDRentalPrice <- map[CodingKeys.trackHDRentalPrice.rawValue]
        releaseDate <- map[CodingKeys.releaseDate.rawValue]
        collectionExplicitness <- map[CodingKeys.collectionExplicitness.rawValue]
        trackExplicitness <- map[CodingKeys.trackExplicitness.rawValue]
        trackCount <- map[CodingKeys.trackCount.rawValue]
        country <- map[CodingKeys.country.rawValue]
        currency <- map[CodingKeys.currency.rawValue]
        primaryGenreName <- map[CodingKeys.primaryGenreName.rawValue]
        contentAdvisoryRating <- map[CodingKeys.contentAdvisoryRating.rawValue]
        artworkUrl600 <- map[CodingKeys.artworkUrl600.rawValue]
        genreIDS <- map[CodingKeys.genreIDS.rawValue]
        genres <- map[CodingKeys.genres.rawValue]
        artistID <- map[CodingKeys.artistID.rawValue]
        artistViewURL <- map[CodingKeys.artistViewURL.rawValue]
    }
    
}
