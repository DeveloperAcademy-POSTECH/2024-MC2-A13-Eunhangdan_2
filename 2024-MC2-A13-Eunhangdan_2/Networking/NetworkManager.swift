//
//  Created by LDW on 5/16/24.
//

import Foundation

//MARK: - 네트워크에서 발생할 수 있는 에러
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking, 서버와 통신하는 클래스 모델

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    //let brickURL = "https://brickset.com/api/v3.asmx/getSets?apiKey=3-GcQZ-hWm5-zxb4C&userHash=3L3kC2zWpk&params={'query':'21348'}"
    typealias SetNetworkCompletion = (Result<[BrickSetApiModel.Set], NetworkError>) -> Void
    typealias MinifigNetworkCompletion = (Result<[MinifigApiModel.Minifig], NetworkError>) -> Void
    typealias MinifigSetNetworkCompletion = (Result<Bool, NetworkError>) -> Void
    
    // BrickSet 네트워킹 요청 함수
    func fetchBrick(searchString: String, completion: @escaping SetNetworkCompletion) {
        let urlString = "\(BrickApi.requestUrl)\(BrickApi.getSets)apiKey=\(BrickApi.apiKey)&userHash=\(BrickApi.userHash)&params={'query':'\(searchString)'}"
        
        print(urlString)
        
        performBrickRequest(with: urlString) { result in
            completion(result)
        }
    }
    

    // Minifig 네트워킹 요청 함수 - 1 : Get minifigs result which checked as owned in brickset DB
    func fetchMinifig(searchString: String, completion: @escaping MinifigNetworkCompletion) {
        let urlString = "\(BrickApi.requestUrl)\(BrickApi.getMinifigCollection)apiKey=\(BrickApi.apiKey)&userHash=\(BrickApi.userHash)&params={'owned':1,'query':'\(searchString)'}"
        
        print(urlString)
        
        performMinifigRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    // Minifig 네트워킹 요청 함수 - 2 : Set minifig as owned in brickset DB
    // Be cautious : "wanted" marking not working in brickset homepage and API both
    func setMinifig(inputString: String, completion: @escaping MinifigSetNetworkCompletion) {
        let urlString = "\(BrickApi.requestUrl)\(BrickApi.setMinifigCollection)apiKey=\(BrickApi.apiKey)&userHash=\(BrickApi.userHash)&params={'own':1}&minifigNumber=\(inputString)"
        
        print(urlString)
        
        performSetMinifigRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    // 실제 brickSet Request하는 함수
    private func performBrickRequest(with urlString: String, completion: @escaping SetNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let bricks = self.parseBrickSetJSON(safeData) {
                print("Parse 실행")
                completion(.success(bricks))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }

            print(safeData)
            
        }
        task.resume()
    }
    
    // 실제 minifig Request하는 함수
    private func performMinifigRequest(with urlString: String, completion: @escaping MinifigNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let minifigs = self.parseMinifigJSON(safeData) {
                print("Parse 실행")
                completion(.success(minifigs))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }

            print(safeData)
            
        }
        task.resume()
    }
    
    
    // !! Be causious
    // Failed without error: https://brickset.com/api/v3.asmx/setMinifigCollection?apiKey=-&userHash=-&params={'own':1}&minifigNumber='51991a'
    // Success : https://brickset.com/api/v3.asmx/setMinifigCollection?apiKey=-&userHash=-&params={'own':1}&minifigNumber=51991a
    
    private func performSetMinifigRequest(with urlString: String, completion: @escaping MinifigSetNetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            let successRange: Range = (200..<300)
            
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            if let response: HTTPURLResponse = response as? HTTPURLResponse{
                   debugPrint("status code: \(response.statusCode)")
                   
                   // 요청 성공 (StatusCode가 200번대)
                   if successRange.contains(response.statusCode){
                       print("Minifigure Set Request 성공")
                       completion(.success(true))
                       
                   } else {
                       print("Minifigure Set Request 실패")
                       completion(.failure(.networkingError))
                   }
               }
        }
        task.resume()
    }
    
    
    // BrickSet json 데이터 파싱
    private func parseBrickSetJSON(_ brickData: Data) -> [BrickSetApiModel.Set]? {
        print(#function)
        // 성공
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let welcome = try decoder.decode(BrickSetApiModel.Welcome.self, from: brickData)
            return welcome.sets
        // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
   
    // Minifig json 데이터 파싱
    private func parseMinifigJSON(_ minifigData: Data) -> [MinifigApiModel.Minifig]? {
        print(#function)
        // 성공
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let welcome = try decoder.decode(MinifigApiModel.Welcome.self, from: minifigData)
            return welcome.minifigs
        // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
