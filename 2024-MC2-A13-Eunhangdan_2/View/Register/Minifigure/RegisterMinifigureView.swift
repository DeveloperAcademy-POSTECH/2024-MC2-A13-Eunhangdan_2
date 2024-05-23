//
//  RegisterMinifigureView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/21/24.
//

import SwiftUI
import SwiftData

struct RegisterMinifigureView: View {

    @Environment (\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var purchaseDate : Date = Date()
    @State var minifigItem : Minifig = Minifig(minifigID: "", minifigName: "", themeCategory: "", includedSetID: [], price: 0.0, minifigCount: 0)
    
    var body: some View {
        List {
            NavigationLink(destination: RegisterMinifigSearchView(minifigItem: $minifigItem).navigationTitle("Minifigure Number") ) {
                HStack {
                    Text("Minifigure Number")
                    Spacer()
                    Text(minifigItem.minifigID != "" ? minifigItem.minifigID : "Search")
                        .foregroundStyle(.gray)
                }
            }
            
            Text("Purchase Date")
            DatePicker("Purchase Date", selection: $purchaseDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("ADD") {
                    do {
                        modelContext.insert(minifigItem)
                        try modelContext.save()
                    } catch {
                        print("Minifigure::Registration::SwiftData::insert Error")
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegisterMinifigureView()
            .navigationTitle("New Minifigure")
    }
    
}
