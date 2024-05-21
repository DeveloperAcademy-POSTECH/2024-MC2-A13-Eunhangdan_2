//
//  BoxDetailView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI

struct BoxDetailView: View {
    var body: some View {
        VStack{
            ScrollView{
                BoxDetailTextView()
                BoxDetailMyMemoryView()
            }
        }
    }
}


#Preview {
    NavigationStack() {
        BoxDetailView()
    }
}
