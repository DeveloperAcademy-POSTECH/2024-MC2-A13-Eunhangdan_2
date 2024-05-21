//
//  Created by LDW on 5/16/24.
//

import Foundation


// MARK: - BrickSet Model
enum BrickSetApiModel {
    // MARK: - Welcome
    struct Welcome: Codable {
        let status: String
        let matches: Int
        let sets: [Set]
    }
    
    // MARK: - Set
    
    struct Set: Codable {
        let setID: Int
        let number: String
        let numberVariant: Int
        let name: String
        let year: Int
        let theme, themeGroup, category: String
        let subtheme: String?
        let released: Bool
        let pieces: Int?
        let minifigs: Int?
        let image: Image
        let bricksetURL: String
        let collection: Collection
        let collections: Collections
        let legoCOM: LEGOCOM
        let rating: Double
        let reviewCount: Int
        let packagingType, availability: String
        let instructionsCount, additionalImageCount: Int
        let ageRange: AgeRange
        let dimensions: Dimensions
        let barcode: Barcode
        let extendedData: ExtendedData
        let lastUpdated: String
        
        enum CodingKeys: String, CodingKey {
            case setID, number, numberVariant, name, year, theme, themeGroup, subtheme, category, released, pieces, minifigs, image, bricksetURL, collection, collections
            case legoCOM = "LEGOCom"
            case rating, reviewCount, packagingType, availability, instructionsCount, additionalImageCount, ageRange, dimensions, barcode, extendedData, lastUpdated
        }
    }
    
    // MARK: - AgeRange
    struct AgeRange: Codable {
        let min, max: Int?
    }
    
    // MARK: - Barcode
    struct Barcode: Codable {
        let ean, upc: String?
        
        enum CodingKeys: String, CodingKey {
            case ean = "EAN"
            case upc = "UPC"
        }
    }
    
    // MARK: - Collection
    struct Collection: Codable {
        let owned, wanted: Bool
        let qtyOwned, rating: Int
        let notes: String
    }
    
    // MARK: - Collections
    struct Collections: Codable {
        let ownedBy, wantedBy: Int
    }
    
    // MARK: - Dimensions
    struct Dimensions: Codable {
        let height, width, depth: Double?
    }
    
    // MARK: - ExtendedData
    struct ExtendedData: Codable {
    }
    
    // MARK: - Image
    struct Image: Codable {
        let thumbnailURL, imageURL: String
    }
    
    // MARK: - LEGOCOM
    struct LEGOCOM: Codable {
        let us: Us
        let de: De
        let ca: CA
        let uk: Uk
        
        enum CodingKeys: String, CodingKey {
            case us = "US"
            case uk = "UK"
            case ca = "CA"
            case de = "DE"
        }
    }
    //MARK: - De (뇌피셜)
    struct De: Codable {
        let retailPrice: Double?
        let dateFirstAvailable, dateLastAvailable: Date?
    }
    
    //MARK: - US (일단 뇌피셜)
    struct Us: Codable {
        let retailPrice: Double?
        let dateFirstAvailable, dateLastAvailable: Date?
    }
    
    
    // MARK: - CA
    struct CA: Codable {
        let retailPrice: Double?
        let dateFirstAvailable, dateLastAvailable: Date?
    }
    
    // MARK: - Uk
    struct Uk: Codable {
        let retailPrice: Double?
        let dateFirstAvailable, dateLastAvailable: Date?
    }
}

//MARK: - Minifig Model
enum MinifigApiModel{
    // MARK: - Welcome
    struct Welcome: Codable {
        let status: String
        let matches: Int
        let minifigs: [Minifig]
    }
    
    // MARK: - Minifig
    struct Minifig: Codable {
        let minifigNumber, name, category: String
        let ownedInSets, ownedLoose, ownedTotal: Int
        let wanted: Bool
    }
}
