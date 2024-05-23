//
//  HandleCSV.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/21/24.
//

import Foundation

func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

func loadBrickSetCSVData() -> [BrickSet] {
    var csvToClass = [BrickSet]()
    
    // CSV file 경로 얻기
    guard let filePath = Bundle.main.path(forResource: "Brickset-MySets-owned", ofType: "csv") else{
        print("Error: file not found")
        return []
    }
    
    // 파일 내용을 엄청 긴 문자열로 변환
    var data: String = ""
    do{
        data = try String(contentsOfFile: filePath)
    } catch {
        print("Error: file convert error")
        return []
    }
    
    // 문자열에서 \r과 \n이 발생하는 것 정리
    data = cleanRows(file: data)
    
    // 엄청 긴 문자열을 rows로 변환, 각 row는 String
    var rows = data.components(separatedBy: "\n")
    
    // rows 헤더 제거
    rows.removeFirst()
    
    // rows를 순회하면서 row를 columns로 쪼개기
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == rows.first?.components(separatedBy: ",").count {
            
            let trimmedColumns = csvColumns.map {
                $0.replacingOccurrences(of: "\"" , with: "", options: .regularExpression)
            }
            
            let lineClass = BrickSet(raw: trimmedColumns)
            
            csvToClass.append(lineClass)
        }
        
    }
    
    return csvToClass
}

func loadMinifigCSVData() -> [Minifig] {
    var csvToClass = [Minifig]()
    
    // CSV file 경로 얻기
    guard let filePath = Bundle.main.path(forResource: "Brickset-minifigs-owned", ofType: "csv") else{
        print("Error: file not found")
        return []
    }
    
    // 파일 내용을 엄청 긴 문자열로 변환
    var data: String = ""
    do{
        data = try String(contentsOfFile: filePath)
    } catch {
        print("Error: file convert error")
        return []
    }
    
    // 문자열에서 \r과 \n이 발생하는 것 정리
    data = cleanRows(file: data)
    
    // 엄청 긴 문자열을 rows로 변환, 각 row는 String
    var rows = data.components(separatedBy: "\n")
    
    // rows 헤더 제거
    rows.removeFirst()
    
    // rows를 순회하면서 row를 columns로 쪼개기
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == rows.first?.components(separatedBy: ",").count {
            
            let trimmedColumns = csvColumns.map {
                $0.replacingOccurrences(of: "\"" , with: "", options: .regularExpression)
            }
            
            let lineClass = Minifig(raw: trimmedColumns)
            csvToClass.append(lineClass)
        }
        
    }
    
    return csvToClass
}
