import Foundation
import SwiftUI

struct AddButton: View {
    @State private var isPresented: Bool = false
    @State var searchText: String = ""
    @State var selectedProductNumber: Int
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("+")
        })
        .sheet(isPresented: $isPresented, content: {
            NewLEGO(isPresented: $isPresented, searchText: $searchText, selectedProductNumber: $selectedProductNumber)
        })
        
    }
    
}

#Preview {
    AddButton(searchText: "", selectedProductNumber: 6000)
}
