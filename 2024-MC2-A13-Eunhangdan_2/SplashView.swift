//
//  SplashView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/24/24.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @State var isSplashTime : Bool = true
    @Environment (\.modelContext) private var modelContext

    var body: some View {
        if isSplashTime {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 245)
            }
            .frame(maxWidth: UIScreen.main.bounds.width
                   , maxHeight: UIScreen.main.bounds.height  )
            .ignoresSafeArea()
            .onAppear() {
                if isFirstLaunch() {
                    // 비동기처리 : 동기처리로 한다면 onAppear가 모두 수행되고 나서 화면이 렌더링 되기 때문에 초기로딩에 스플레시 화면이 보이지 않는다. 
                    DispatchQueue.main.async {
                        print("first")
                        let context = modelContext
                        let brickSets = loadBrickSetCSVData()
                        let minifigs = loadMinifigCSVData()
                        
                        do{
                            for brickSet in brickSets {
                                context.insert(brickSet)
                            }
                            
                            for minifig in minifigs {
                                context.insert(minifig)
                                // 미니 피규어 마다 등록된 세트 순회
                                for includedSetID in minifig.includedSetID{
                                    let setPredicate = #Predicate<BrickSet> {
                                        $0.setID == includedSetID
                                    }
                                    
                                    let descriptor = FetchDescriptor<BrickSet>(predicate: setPredicate)
                                    let brickSets = try context.fetch(descriptor)
                                    // 탐색 완료 후 brickSet 리스트를 순회하며 속성 추가
                                    for brickSet in brickSets {
                                        brickSet.minifigureIdList.append(minifig.minifigID)
                                        context.insert(brickSet)
                                    }
                                }
                            }
                            
                            try context.save()
                            self.isSplashTime = false
                        } catch {
                            print("Error: Failed to save CSV Data to SwiftData")
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2 ) {
                        self.isSplashTime = false
                    }
                }
            }
        } else {
            ContentView()
        }
    }
}

#Preview {
    SplashView()
}
