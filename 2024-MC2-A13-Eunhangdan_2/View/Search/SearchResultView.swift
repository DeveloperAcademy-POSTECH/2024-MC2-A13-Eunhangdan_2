import Foundation
import SwiftUI
import SwiftData

struct SearchResultView: View{
    @Binding var brickSetList: [BrickSet]
    @Binding var limitedBrickSetList: [BrickSet]
    @Binding var minifigsList: [Minifig]
    @Binding var limitedMinifigsList: [Minifig]
    @Binding var searchActivated: Bool
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("")
                    .frame(height: 10)
                NavigationLink {
                    ScrollView {
                        searchedBrickSets(list: brickSetList)
                    }
                } label: {
                    HStack{
                        Text("LEGO Search Result")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                searchedBrickSets(list: limitedBrickSetList)
                Spacer()
                
                Divider()
                
                NavigationLink {
                    ScrollView{
                        searchedMinifigure(list: minifigsList)
                    }
                } label: {
                    HStack{
                        Text("Minifigure Search Result")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                searchedMinifigure(list: limitedMinifigsList)
                Spacer()
            }
            .padding()
            .navigationBarTitle("Search Result", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        searchActivated = false
                    } label: {
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview {
    SearchResultView(brickSetList: .constant([]), limitedBrickSetList: .constant([]), minifigsList: .constant([]), limitedMinifigsList: .constant([]), searchActivated: .constant(true))
}
