//
//  SwiftData + Typealias.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/18/24.
//

import SwiftUI
import SwiftData

typealias BrickSet = ModelSchemaV1.BrickSet
typealias Minifig = ModelSchemaV1.Minifig
typealias BrickVillege = ModelSchemaV1.BrickVillege

// userDefault 저장을 이용해서 앱이 첫 실행인지 확인
func isFirstLaunch() -> Bool {
    let defaults = UserDefaults.standard
    if defaults.bool(forKey: "hasLaunchedBefore") {
        return false
    } else {
        defaults.set(true, forKey: "hasLaunchedBefore")
        return true
    }
}
