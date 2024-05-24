//
//  MyPageWhoMadeThis.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by kyunglimkim on 5/23/24.
//

import SwiftUI

struct MyPageWhoMadeThis: View {
    
    let teamName: [String] = ["Andrew", "Gang", "Gimli", "Mari", "Marty", "Min"]
    let teamRole1: [String] = ["Lead Engineer", "Lead Engineer", "Lead Designer", "Lead Designer", "ILEGOU Designer", "Lead Engineer"]
    let teamRole2: [String] = ["Dead Designer", "Lead Designer", "Bread Engineer", "Lead Engineer", "ILEGOU Engineer", "Bread Designer"]
    let teamBasicInfo : [String] = ["9월 9일생, INTJ", "11월 15일생, INTJ", "10월 15일생, ENFJ", "1월 30일생, INTP", "6월 13일생, ISFJ", "3월 22일생, INFJ"]
    let teamTMI : [String] = ["장남, 치킨 하루에 3번 먹을 수 있음", "여동생있음, 주말에 밭관리하러감", "외동, 요새 쿠키런 하는 중임", "오빠있음, 팀회의때 프로 출마러임", "장남, 오른손잡이, 막창수저임", "여동생있음, 미국 유학 경험 있음"]
    let teamFace: [Image] = [Image("myTeamAndrew"), Image("myTeamGang"), Image("myTeamGimli"), Image("myTeamMari"), Image("myTeamMarty"), Image("myTeamMin")]
    let teamSentence: [String] = ["앤드류 한마디", "함께 고생했던만큼 행복해지기를☺️", "난 우리 팀 너무 좋아. 갱 마리 마티 민 앤드류 최고!", "마리 한마디", "I LEGO U, Seungwon❤️", "LEGOphia가 앱스토어에 출시되는 그 날까지!"]
    var body: some View {
        ScrollView{
            ZStack{
                Color(.secondarySystemBackground)
              //      .opacity(2)
                VStack{
                    //               List{
                    //                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 361), spacing: 10)], content: {
                    
                    ForEach(teamName.indices, id: \.self) {  teams in
                        //
                        //                        NavigationLink {
                        //
                        //                        } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .frame(minWidth: 361, minHeight: 165)
                                .foregroundColor(.white)
                            VStack{
                                teamFace[teams]
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(teamName[teams])
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                        VStack{
                                            Text(teamRole1[teams])
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                            Text(teamRole2[teams])
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer().frame(height: 15)
                                    VStack(alignment: .leading){
                                        Text(teamBasicInfo[teams])
                                            .font(.subheadline)
                                        Text(teamTMI[teams])
                                            .font(.subheadline)
                                        Spacer().frame(height: 15)
                                        Text("\"\(teamSentence[teams])\"")
                                            .font(.headline)
                                    }
                                }
                            }.padding()
                        }.padding()
                    }
                    
                    
                    //                    }
                    ////                    })
                    //                }
                }}
        }.navigationTitle("Credit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack() {
        MyPageWhoMadeThis()
    }
}
