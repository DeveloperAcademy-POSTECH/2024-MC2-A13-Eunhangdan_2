//
//  MyPageView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by LDW on 5/23/24.
//

import SwiftUI
import SwiftData

struct MyPageView: View {
    
    // @Environment (\.modelContext) private var modelContext
    @Query(sort: \Minifig.minifigID) var minifigs: [Minifig]
    @Query(sort: \BrickSet.setID) var LEGOsets: [BrickSet]
    var body: some View {
        VStack{
            NavigationStack {
                List{
                    Section {
                        HStack{
                            Spacer()
                            VStack(alignment: .center){
                                Spacer().frame(height: 20)
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 85)
                                    .foregroundStyle(.red)
                                
                                Spacer().frame(height: 13)
                                
                                Text("Hello, 최승원 님")
                                    .font(.title)
                                    .bold()
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    // 1번 섹션
                    Section {
                            HStack{
                               Image("userLEGOnumber")
                                    .resizable()
                                    .frame(width: 31, height: 37)
                                VStack(alignment: .leading){
                                    Text("LEGO You own")
                                        .bold()
                                    Text("\(LEGOsets.count)")
                                        .font(.subheadline)
                                        .opacity(0.6)
                                }
                            }
                    } header: {
                    Text("My collecttion")
                    }
                    .listSectionSpacing(15)
                    
                    Section() {
                            HStack{
                               Image("batteryblockMypage")
                                    .resizable()
                                    .frame(width: 35, height: 25)
                                VStack(alignment: .leading){
                                    Text("Minifigure You own")
                                        .bold()
                                    Text("\(minifigs.count)")
                                        .font(.subheadline)
                                        .opacity(0.6)
                                }
                            }
                    }
                    
                    // 3번 섹션
                    Section {
                        NavigationLink {
                            MyPageIfYouNeedHelpView()
                        } label: {
                            Text("Help")
                        }
                        
                        NavigationLink {
                            MyPageWhoMadeThis()
                        } label: {
                            Text("Credit")
                        }
                        
//                        NavigationLink {
//                            
//                        } label: {
                            HStack{
                                Text("Version")
                                Text("1.0.0")
                                    .padding(.leading, 8)
                            }
//                        }

                    } header: {
                    Text("other")
                    }
                
                    
                }
                .navigationTitle("My Page")
            }
            
        }

    }
}

#Preview {
    MyPageView()
}
