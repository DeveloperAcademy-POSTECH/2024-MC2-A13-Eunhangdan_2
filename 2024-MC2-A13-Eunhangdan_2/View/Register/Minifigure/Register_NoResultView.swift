//
//  Register_NoResultView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/21/24.
//

import SwiftUI

struct Register_NoResultView: View {
    var body: some View {
        VStack {
            
            Spacer()
            Text("No such item with the input")
                .font(.title)
                .fontWeight(.bold)
            
            Text("")
            
            Group {
                Text("Registration needs a minifigure's correct ID.")
                Text("Please re-confirm and try with the correct one.")
            }
            .font(.caption)
            
            Spacer()
            
        }
    }
}

#Preview {
    Register_NoResultView()
}
