//
//  TotalTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/21/24.
//

import SwiftUI

struct TotalTestView: View {
    var body: some View {
        NavigationStack{
            
            List {
                NavigationLink {
                    NetworkTestView()
                } label: {
                    Text("NetworkTestView")
                }

                NavigationLink {
                    SwiftDataTestView()
                } label: {
                    Text("SwiftDataTestView")
                }
                
                NavigationLink {
                    HandleCSVTestView(brickSets: loadBrickSetCSVData(), minifigs: loadMinifigCSVData())
                } label: {
                    Text("HandleCSVTestView")
                }

                
            }
            .navigationTitle("종합 테스트 화면")
        }
        
        
        
    }
}

#Preview {
    TotalTestView()
}
