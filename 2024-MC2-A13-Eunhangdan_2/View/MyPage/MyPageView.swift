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
                                    .font(.title2)
                                    .bold()
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    // 1번 섹션
                    Section(header: Text("나의 수집 기록")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title2)) {
                            HStack{
                               Image("userLEGOnumber")
                                    .resizable()
                                    .frame(width: 31, height: 37)
                                VStack(alignment: .leading){
                                    Text("보유 레고 개수")
                                        .bold()
                                    Text("\(LEGOsets.count)개")
                                        .font(.subheadline)
                                        .opacity(0.6)
                                }
                            }
                    }
                    .listSectionSpacing(15)
                    
                    Section() {
                            HStack{
                               Image("batteryblockMypage")
                                    .resizable()
                                    .frame(width: 35, height: 25)
                                VStack(alignment: .leading){
                                    Text("보유 피규어 개수")
                                        .bold()
                                    Text("\(minifigs.count)개")
                                        .font(.subheadline)
                                        .opacity(0.6)
                                }
                            }
                    }
                    
                    // 3번 섹션
                    Section(header: Text("기타")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title2)) {
                        NavigationLink {
                            MyPageIfYouNeedHelpView()
                        } label: {
                            Text("도움이 필요하다면?")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("제작한 사람들")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("버전")
                        }

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
