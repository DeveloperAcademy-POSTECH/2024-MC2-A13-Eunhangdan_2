import Foundation
import SwiftUI

struct SearchLEGOBoxForAdding: View {
    @Binding var searchText: String
    @Binding var selectedProductNumber: Int
    @Binding var isProductSelected: Bool
    @State var setList: [BrickSetApiModel.Set] = []
    @State private var brickNumber: String = ""
    var networkManager = NetworkManager.shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var searchActivated : Bool = false
    
    var body: some View {
        VStack{
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Product Number")
        .onSubmit(of: .search) {
            searchActivated = true
            
            if searchText == "" {return}
            networkManager.fetchBrick(searchString: searchText) { result in
                switch result {
                case .success(let sets):
                    setList.removeAll()
                    for set in sets {
                        setList.append(set)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
        if searchActivated {
            if setList.isEmpty {
                EmptySearchResultScreen()
            } else {
                ScrollView {
                    ForEach(setList, id: \.setID) { set in
                        
                        HStack{
                            AsyncImage(url: URL(string: "\(set.image.imageURL)")) {image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                // 김리의 프로그레스 뷰 넣기
                            }
                            .frame(width: 100, height: 100)
                            .clipped()
                            
                            VStack {
                                Text("\(set.subtheme ?? "") \(set.name)")
                                Text("")
                                Text("Released Date: \(String(set.year))")
                            }
                            
                            Button {
                                selectedProductNumber = Int(set.number) ?? 0
                                presentationMode.wrappedValue.dismiss()
                                isProductSelected = true
                            } label: {
                                Text("Choose")
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.black, lineWidth: 1)
                                            .padding()
                                    )
                            }
                        }
                        
                    }
                }

            }
        } else {
            Spacer()
        }
        
        
        
        
    }
}

#Preview {
    SearchLEGOBoxForAdding(searchText: .constant("43222"), selectedProductNumber: .constant(43222), isProductSelected: .constant(false), setList: [])
}
