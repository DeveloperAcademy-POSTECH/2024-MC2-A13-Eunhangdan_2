import Foundation
import SwiftUI

struct SearchResultView: View{
    @State var searchText: String
    
    var body: some View {
        VStack{
            HStack{
                Text("about \(searchText)").font(.title)
                Spacer()
            }
            Spacer()
            HStack{
                Text("LEGO Search Result")
                    .font(.title)
                    .bold()
                Spacer()
                NavigationLink {
                    SearchedLEGODetailView()
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            makeBoxList()
            Divider()
            HStack{
                Text("Minifigure Search Result")
                    .font(.title)
                    .bold()
                Spacer()
                NavigationLink {
                    SearchedMinifigureDetailView()
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            makeMiniFigureList()
        }.padding()
        
    }
}

@ViewBuilder
func makeBoxList() -> some View {
    HStack{
        Rectangle()
            .frame(width: 150, height: 130)
        
        Spacer()
        VStack{
            Text("Minions - The rise of Gru")
            Text("")
            Text("Released Date: 2020.12.11")
        }
    }
    HStack{
        Rectangle()
            .frame(width: 150, height: 130)
        Spacer()
        VStack{
            Text("Minions - The rise of Gru")
            Text("")
            Text("Released Date: 2020.12.11")
        }
    }
    
}

@ViewBuilder
func makeMiniFigureList() -> some View {
    HStack{
        Rectangle()
            .frame(width: 150, height: 130)
        VStack{
            Text("Minions - The rise of Gru")
            Text("")
            Text("Released Date: 2020.12.11")
        }
        Spacer()
    }
    HStack{
        Rectangle()
            .frame(width: 150, height: 130)
        VStack{
            Text("Minions - The rise of Gru")
            Text("")
            Text("Released Date: 2020.12.11")
        }
        Spacer()
    }
}

#Preview {
    SearchResultView(searchText: "")
}
