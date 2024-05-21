import Foundation
import SwiftUI

struct SeriesDetailView: View {
    @State var seriesTitle: String
    
    var body: some View {
        VStack {
            ScrollView{
                ForEach(0..<11) { num in
                    HStack{
                        Rectangle()
                            .foregroundStyle(.pink)
                            .frame(width: 150, height: 130)
                        Spacer()
                        VStack{
                            Text("Minions - The rise of Gru")
                            Text("")
                            Text("Released Date: 2020.12.11")
                        }
                    }
                }
                ForEach(0..<11) { num in
                    HStack{
                        Rectangle()
                            .foregroundStyle(.blue)
                            .frame(width: 150, height: 130)
                        Spacer()
                        VStack{
                            Text("Minions - The rise of Gru")
                            Text("")
                            Text("Released Date: 2020.12.11")
                        }
                    }
                }
                
            }
        }
        .navigationTitle(seriesTitle)
        .padding()
        
    }
}

#Preview {
    SeriesDetailView(seriesTitle: "Starwars")
}
