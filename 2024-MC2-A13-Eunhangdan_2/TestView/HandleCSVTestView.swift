//
//  HandleCSVTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/21/24.
//

import SwiftUI

struct HandleCSVTestView: View {
    
    @State var brickSets: [BrickSet]
    @State var minifigs: [Minifig]
    
    var body: some View {
        TabView{
            NavigationStack{

                Text("이미 소유하고 있는 레고 목록")

                List{
                    ForEach(brickSets){ brickSet in
                        NavigationLink(destination: {}) {
                            VStack{
                                HStack{
                                    Text("BrickNumber : \(brickSet.setID)")
                                    Spacer()
                                }
                                HStack {
                                    Text("BrickName: \(brickSet.setName)")
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
            }
            .tabItem {
                Text("BrickSetCSV")
            }
            
            NavigationStack{
                
                Text("이미 소유하고 있는 레고 목록")
                
                List{
                    ForEach(minifigs){ minifig in
                        NavigationLink(destination: {}) {
                            VStack{
                                HStack{
                                    Text("MinifigNumber : \(minifig.minifigID)")
                                    Spacer()
                                }
                                HStack {
                                    Text("MinifigName: \(minifig.minifigName)")
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
            }
            .tabItem {
                Text("MinifigCSV")
            }
        }
    }
}

#Preview {
    HandleCSVTestView(brickSets: loadBrickSetCSVData(), minifigs: loadMinifigCSVData())
}
