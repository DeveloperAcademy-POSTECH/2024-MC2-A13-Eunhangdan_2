//
//  RegisterMinifigSearchView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/21/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var minifigList: [MinifigApiModel.Minifig]
    @Binding var searchActivated: Bool
    
    @FocusState var isFocus: Bool
    @Binding var text: String
    
    var networkManager = NetworkManager.shared
    @State var setMinifig = false
    @State var getMinifig = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("atn011", text: $text)
                    .foregroundColor(.primary)
                    .focused($isFocus)
                    .onSubmit {
                        searchActivated = true
                        
                        networkManager.setMinifig(inputString: text) { result in
                            switch result {
                            case .success(_):
                                setMinifig = true
                                
                                networkManager.fetchMinifig(searchString: text) { result in
                                    switch result {
                                    case .success(let minifigs):
                                        getMinifig = true
                                        
                                        minifigList.removeAll()
                                        
                                        minifigs.forEach {
                                            minifigList.append($0)
                                        }
                                        
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                }
                                
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }
                    .submitLabel(.search)
                    .onAppear() {
                        isFocus = true
                    }

                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct RegisterMinifigSearchView: View {

    @Binding var minifigItem : Minifig
    @State var searchText: String = ""
    @State var searchActivated : Bool = false
    
    @State private var minifigList: [MinifigApiModel.Minifig] = []
    
    let minifigImageUrlPrefix = "https://img.bricklink.com/ItemImage/MN/0/"
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        VStack {
            SearchBar(minifigList: $minifigList, searchActivated: $searchActivated, text: $searchText)
            
            if searchActivated {
                if !minifigList.isEmpty {
                    ForEach(minifigList, id: \.minifigNumber) { minifig in
                        HStack{
                            AsyncImage(url: URL(string: minifigImageUrlPrefix + searchText + ".png")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 128, height: 128)
                            .clipShape(.rect(cornerRadius: 25))
                            Text("Minifig Name : \(minifig.name)")
                                .padding(.vertical, 16)
                            Button {
                                minifigItem.minifigID = minifig.minifigNumber
                                minifigItem.minifigName = minifig.name
                                minifigItem.themeCategory = minifig.category
                                
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Select")
                                    .padding(5)
                                    .background(.gray.opacity(0.12))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    Spacer()
                } else {
                    Register_NoResultView()
                }
            } else {
                Spacer()
            }
        }
    }
}

#Preview {
    RegisterMinifigSearchView(minifigItem: .constant(Minifig(minifigID: "", minifigName: "", themeCategory: "", includedSetID: [], price: 0.0, minifigCount: 0)))
}
