import Foundation
import SwiftUI

struct NewLEGO: View {
    @State var assembled: Bool = false
    @State private var date = Date()
    @State private var isSearchSelected: Bool = false
    @State private var isProductSelected: Bool = false
    @Binding var searchText: String
    @Binding var selectedProductNumber: Int
    
    var body: some View {
        NavigationStack {
            List{
                HStack{
                    Text("LEGO Number")
                    NavigationLink {
                        SearchLEGOBoxForAdding(searchText: $searchText, selectedProductNumber: $selectedProductNumber, isProductSelected: $isProductSelected)
                    } label: {
                        HStack {
                            Spacer()
                            if !isProductSelected {
                                Text("Search")
                                Image("chevron.forward")
                            } else {
                                Text("\(String(selectedProductNumber))")
                            }
                        }
                        
                    }
                }
                Text("Purchase Date")
                DatePicker(
                    "Purchase Date",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                
                Toggle("Assembled", isOn: $assembled)
            }.navigationTitle("New LEGO")
        }
    }
}

#Preview{
    NewLEGO(searchText: .constant("6000"), selectedProductNumber: .constant(6000))
}

