//
//  MyPageWhoMadeThis.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by kyunglimkim on 5/23/24.
//

import SwiftUI

struct MyPageWhoMadeThis: View {
        struct teamMember: Identifiable {
            var id = UUID()
            var teamName : String
            var teamRole1 : String
            var teamRole2 : String
            var teamBasicInfo : String
            var teamTMI : String
            var teamFace : Image
            var teamSentence : String
            }
    
    @State var teamMembers: [teamMember] = [
            teamMember(teamName: "Andrew", teamRole1: "Lead Engineer", teamRole2: "Dead Designer", teamBasicInfo: "9월 9일생, INTJ", teamTMI: "장남, 치킨 하루에 3번 먹을 수 있음", teamFace: Image("myTeamAndrew"), teamSentence: "여러분과 함께해서 의미 있었습니다! 언젠가 승원님께 정말로 도움이 되는 앱을 만들 수 있는 날이 오길..."),
            teamMember(teamName: "Gang", teamRole1: "Lead Engineer", teamRole2: "Lead Designer", teamBasicInfo: "11월 15일생, INTJ", teamTMI: "여동생있음, 주말에 밭관리하러감", teamFace: Image("myTeamGang"), teamSentence: "함께 고생했던만큼 행복해지기를☺️"),
            teamMember(teamName: "Gimli", teamRole1: "Lead Designer", teamRole2: "Bread Engineer", teamBasicInfo: "10월 15일생, ENFJ", teamTMI: "외동, 요새 쿠키런 하는 중임", teamFace: Image("myTeamGimli"), teamSentence: "난 우리 팀 너무 좋아. 갱 마리 마티 민 앤드류 최고!"),
            teamMember(teamName: "Mari", teamRole1: "Lead Designer", teamRole2: "Lead Engineer", teamBasicInfo: "1월 30일생, INTP", teamTMI: "오빠있음, 팀회의때 프로 출마러임", teamFace: Image("myTeamMari"), teamSentence: "즐거운 레고 생활 되시길,,,"),
            teamMember(teamName: "Marty", teamRole1: "ILEGOU Designer", teamRole2: "ILEGOU Engineer", teamBasicInfo: "6월 13일생, ISFJ", teamTMI: "장남, 오른손잡이, 막창수저임", teamFace: Image("myTeamMarty"), teamSentence: "I LEGO U, Seungwon❤️"),
            teamMember(teamName: "Min", teamRole1: "Lead Engineer", teamRole2: "Bread Designer", teamBasicInfo: "3월 22일생, INFJ", teamTMI: "여동생있음, 미국 유학 경험 있음", teamFace: Image("myTeamMin"), teamSentence: "LEGOphia가 앱스토어에 출시되는 그 날까지!")
        ]
    
    var body: some View {
        ScrollView{
            ZStack{
                Color(.secondarySystemBackground).ignoresSafeArea()
                VStack{
                    ForEach(teamMembers) { member in
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                            VStack{
                                member.teamFace
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(member.teamName)
                                            .font(.title)
                                            .bold()
                                        Spacer()
                                            .frame(width: 137)
                                        VStack(alignment:.trailing){
                                            Text(member.teamRole1)
                                                .font(.footnote)
                                            Text(member.teamRole2)
                                                .font(.footnote)
                                        }
                                    }
                                    Spacer().frame(height: 16)
                                    
                                    Text(member.teamBasicInfo)
                                        .font(.subheadline)
                                    Text(member.teamTMI)
                                        .font(.subheadline)
                                }
                                Spacer().frame(height: 23)
                                
                                Text("\"\(member.teamSentence)\"")
                                    .font(.headline)
                                    .padding()
                                Spacer().frame(height: 20)
                            }
                        }
                    }.padding()
                }
            }.navigationTitle("Credit")
                .navigationBarTitleDisplayMode(.inline)
        }
            }
        }

#Preview {
    NavigationStack() {
        MyPageWhoMadeThis()
    }
}
