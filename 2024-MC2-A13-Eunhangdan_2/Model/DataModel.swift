//
//  DataModel.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/17/24.
//

import SwiftUI
import SwiftData

//MARK: - 모델 스키마 버전 1 (차후 버전이 바뀔 것을 대비하여)
enum ModelSchemaV1: VersionedSchema {
    //MARK: - 버전 식별자
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [BrickSet.self, Minifig.self, BrickVillege.self]
    }
    
    //MARK: - 부가 정보 (사진, 좌표)
    @Model class Photo {
        var id: UUID
        var createdDate: Date
        @Attribute(.externalStorage) var photo: Data

        init(photo: Data) {
            self.id = UUID()
            self.createdDate = Date()
            self.photo = photo
        }
    }
    
//    @Model
//    class Coordinate {
//        var id: UUID = UUID()
//        var x: Double
//        var y: Double
//        var rotationDegree: Int // 회전 정도
//        //@Relationship(deleteRule: .nullify, inverse: \BrickVillege.minifigureHoleCoordinate) weak var parentVillage: BrickVillege?
//        
//        init(x: Double = 0.0 , y: Double = 0.0, rotationDegree: Int = 0) {
//            self.x = x
//            self.y = y
//            self.rotationDegree = rotationDegree
//        }
//    }
    
    //MARK: - BrickSet 모델 정의
    @Model
    final class BrickSet {
        @Attribute(.unique) var setID: String // 박스 품번
        var theme: String // 테마
        var subtheme: String // 테마 부제
        var setName: String // 세트 이름
        var pieces: Int // 피스 수
        var isAssembled: Bool // 조립 여부
        var price: Double // USD 가격
        // var minifigureCount: Int // 미니피규어 개수 (없다면 0으로)
        var minifigureIdList: [String] // 미니피규어 아이디 리스트
        var setImageURL: String // 세트 이미지
        @Attribute(.externalStorage) var setImage: Data?
        var isFavorite: Bool // 즐겨찾기 여부
        var isOwned: Bool // 보유 여부
        // var isWanted: Bool // 찜 여부  삭제
        @Relationship(deleteRule: .cascade) var photos:[Photo] // 직접 찍은 사진 (없다면 빈 배열)
        var purchaseDate: Date // 구매일
        var releasedDate: Int // 출시연도
        var discontinuedDate : Date? // 단종일
   
        init(setID: String, theme: String, subtheme: String, setName: String, pieces: Int, isAssembled: Bool, price: Double, minifigureIdList: [String] = [], setImageURL: String, isFavorite: Bool, isOwned: Bool, photos: [Photo], purchaseDate: Date, releasedDate: Int, discontinuedDate: Date? = nil) {
            self.setID = setID
            self.theme = theme
            self.subtheme = subtheme
            self.setName = setName
            self.pieces = pieces
            self.isAssembled = isAssembled
            self.price = price
            self.minifigureIdList = minifigureIdList
            self.setImageURL = setImageURL
            self.isFavorite = isFavorite
            self.isOwned = isOwned
            self.photos = photos
            self.purchaseDate = purchaseDate
            self.releasedDate = releasedDate
            self.discontinuedDate = discontinuedDate
            
            if !setImageURL.isEmpty {
                let url = URL(string: setImageURL)!
                self.downloadImage(from: url)
            }
            
        }
        
        init(raw: [String]){
            self.setID = raw[0]
            self.theme = raw[1]
            self.subtheme = raw[2]
            self.setName = raw[4]
            self.pieces = Int(raw[6])!
            self.isAssembled = true
            if raw[8] != "" {
                self.price = Double(raw[8])!
            } else {
                self.price = 0
            }
            self.minifigureIdList = []
            self.setImageURL = ""
            self.isFavorite = false
            self.isOwned = true
            self.photos = []
            self.purchaseDate = Date()
            self.releasedDate = Int(raw[3])!
            self.discontinuedDate = discontinuedDate
        }
        
        // API 모델 >> SwiftData 모델로 변환
        convenience init(brickSet: BrickSetApiModel.Set) {
            let subtheme = brickSet.subtheme != nil ? brickSet.subtheme! : ""
            let pieces = brickSet.pieces != nil ? brickSet.pieces! : 0
            let price = brickSet.legoCOM.us.retailPrice != nil ? brickSet.legoCOM.us.retailPrice! : 0.0
            
            self.init(setID: String(brickSet.setID), theme: brickSet.theme, subtheme: subtheme, setName: brickSet.name, pieces:pieces, isAssembled: false, price: price, minifigureIdList: [], setImageURL: brickSet.image.imageURL, isFavorite: false, isOwned: false, photos: [], purchaseDate: Date(), releasedDate: brickSet.year)
        }
        
        // url에서 데이터 받기
        private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        // 실제 호출되는 다운로드 이미지
        func downloadImage(from url: URL) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // 작업 완료 후 메인 쓰레드로
                DispatchQueue.main.async() { [weak self] in
                    self?.setImage = data
                }
            }
        }
        
    }
    
    //MARK: - Minifig 모델 정의
    @Model
    final class Minifig {
        
        @Attribute(.unique) var minifigID: String // 미니 피규어 아이디
        var minifigName: String // 미니 피규어 이름
        var themeCategory: String // 테마 카테고리    테마라 서브테마로 분리가 좋을듯? 카테고리 배열로 슬래쉬 구분
        var includedSetID: [String] // 포함된 세트 품번     여러 세트에 포함될 수 있으므로 배열로, 하이픈 필요 여부에 따라 String이나 Int
        var price: Double // USD 가격
        var minifigCount: Int // 미니 피규어 개수
        var minifigImageURL: String // 피규어 이미지 url 주소
        var createdDate: Date // 생성 날짜
        @Attribute(.externalStorage) var minifigImage: Data? // 미니 피규어 사진
 
        var splitCategory: [String] {
            if themeCategory == "" {return []}
            return themeCategory
                .components(separatedBy: "/") // "/"를 기준으로 문자열 분리
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // 앞뒤 공백 제거
        }
        
        init(minifigID: String, minifigName: String, themeCategory: String, includedSetID: [String], price: Double, minifigCount: Int, minifigImageURL: String = "") {
            self.minifigID = minifigID
            self.minifigName = minifigName
            self.themeCategory = themeCategory
            self.includedSetID = includedSetID
            self.price = price
            self.minifigCount = minifigCount
            self.minifigImageURL = minifigImageURL
            self.minifigImage = nil
            self.createdDate = Date()
            
            if !minifigImageURL.isEmpty {
                let url = URL(string: minifigImageURL)!
                self.downloadImage(from: url)
            }
        }
        
        init(raw: [String]){
            self.minifigID = raw[0]
            self.minifigName = raw[1]
            self.themeCategory = raw[3]
            self.includedSetID = raw[4]
                .components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            if raw[8] != "" {
                self.price = Double(raw[8])!
            } else {
                self.price = 0.0
            }
            self.minifigCount = 0
            self.minifigImageURL = ""
            self.minifigImage = nil
            self.createdDate = Date()
        }
        
        // API 모델 >> SwiftData 모델로 변환
        convenience init(minifig: MinifigApiModel.Minifig){
            self.init(minifigID: minifig.minifigNumber, minifigName: minifig.name, themeCategory: minifig.category, includedSetID: [], price: 0, minifigCount: 0, minifigImageURL: "")
        }
        
        // url에서 데이터 받기
        private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        // 실제 호출되는 다운로드 이미지
        func downloadImage(from url: URL) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // 작업 완료 후 메인 쓰레드로
                DispatchQueue.main.async() { [weak self] in
                    self?.minifigImage = data
                }
            }
        }
    }
    
    //MARK: - BrickVillege 모델 정의
    @Model
    final class BrickVillege {
        @Attribute(.unique) var backgroundID: UUID
        var backgroundName: String // 배경 이름
        @Attribute(.externalStorage) var backgroundImage: Data? // 배경 이미지
        var categoryInfo: String // 카테고리 정보
       //  @Relationship(deleteRule: .cascade) var minifigureHoleCoordinate: [Coordinate] // 미니피규어 좌표, 아래와 배열 인덱스로 조율, 필요 없을지도?
        // @Relationship(deleteRule: .cascade, inverse: \Coordinate.parentVillage)
        var registeredMinifigureID: [String] // 등록된 미니피규어 아이디(품번)
        //var minifigureHoleCoordinate: [Coordinate]// 미니피규어 좌표
        var xCoordi: [Double] = []
        var yCoordi: [Double] = []
        var rotationDegree: [Double] = []
        
        init(backgroundID: UUID, backgroundName: String, backgroundImage: Data? = nil, categoryInfo: String, registeredMinifigureID: [String], xCoordi: [Double], yCoordi: [Double], rotationDegree: [Double]) {
            self.backgroundID = backgroundID
            self.backgroundName = backgroundName
            self.backgroundImage = backgroundImage
            self.categoryInfo = categoryInfo
            self.registeredMinifigureID = registeredMinifigureID
            self.xCoordi = xCoordi
            self.yCoordi = yCoordi
            self.rotationDegree = rotationDegree
        }
    }
}
