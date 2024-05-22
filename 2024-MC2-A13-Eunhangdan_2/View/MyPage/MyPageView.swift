//
//  MyPageView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by LDW on 5/23/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        VStack{
            NavigationStack {
                List{
                    Section {
                        HStack{
                            Text("Hello, 최승원 님")
                                .font(.largeTitle)
                                .bold()
                            
                            Spacer()
                            
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.red)
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    // 1번 섹션
                    Section(header: Text("내 레고 보유 현황")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title2)) {
                        NavigationLink {
                            
                        } label: {
                            Text("보유 레고 개수")
                        }
                        NavigationLink {
                            
                        } label: {
                            Text("보유 피규어 개수")
                        }
                    }
                   
                    // 2번 섹션
                    Section(header: Text("내 레고의 가치")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title2)) {
                        NavigationLink {
                            
                        } label: {
                            Text("내 레고 중고가 알아보기")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("내 피규어 중고가 알아보기")
                        }
                    }
                    
                    // 3번 섹션
                    Section(header: Text("기타")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.title2)) {
                        NavigationLink {
                            
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
                    
                    Section {
                        Button(action: {
                            
                        }, label: {
                            Text("내 레고 데이터 내보내기/받기")
                        })
                        
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
