//
//  MinifigureTabView.swift
//  EunhaengdanVol1
//
//  Created by lovehyun95 on 5/20/24.
//

import SwiftUI
struct MinifigureTabView: View {
    @State var scrolledID: UUID?
    @State var items: [minifigureItem] = [
        .init(minifigureImage: "image65"),
        .init(minifigureImage: "image65"),
        .init(minifigureImage: "image65"),
        .init(minifigureImage: "image65"),
        .init(minifigureImage: "image65"),
        .init(minifigureImage: "image65")
    ]
    @State var villageImage: [villageItem] = [
        .init(villageImageString: "Village", villageBackGroundColor: .yellow),
        .init(villageImageString: "Village", villageBackGroundColor: .blue),
        .init(villageImageString: "Village", villageBackGroundColor: .mint),
        .init(villageImageString: "Village", villageBackGroundColor: .cyan),
        .init(villageImageString: "Village", villageBackGroundColor: .green),
        .init(villageImageString: "Village", villageBackGroundColor: .brown)
    ]
    let textLeftedge : CGFloat = 30
    init() {
        if let firstItemID = items.first?.id {
            _scrolledID = State(initialValue: firstItemID)
        }
    }
    
    var body: some View {
        NavigationView(){
            ScrollView{
                VStack{
                    HStack(alignment: .bottom){
                        Text("My LEGO Village")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }.padding(.leading, textLeftedge)
                    ZStack{
                        villageCarousel(data: villageImage, itemWidth: 315, activeID: $scrolledID){item, isFocused  in
                            VillageView(villageImageString: item.villageImageString, villageBackGroundColor: item.villageBackGroundColor)
                        } // 마을 배경으로 쓰일 이미지 파일만 받도록 수정 필요
                    }.frame(width: 375,height: 245)
                    Spacer(minLength: 30)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            //.border(Color.black)
                            .frame(width: 393, height: 207)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.13), radius: 7.40)
                        VStack{
                            Spacer(minLength: 10)
                            HStack(alignment: .bottom){
                                Text("Harry Potter") // 짝수 번 테마 이름
                                    .font(.title2)
                                    .bold()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 22))
                                    .foregroundColor(.gray)
                                Spacer()
                            }.padding(.leading, textLeftedge)
                            Carousel(data: items, itemWidth: 55, activeID: $scrolledID) { item, isFocused in
                                MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused)
                            } // 미니 피규어 정보 수정 필요
                            Spacer(minLength: 10)
                        }.frame(width: 393, height: 180)
                    }
                    ZStack{
                        VStack{
                            Spacer(minLength: 10)
                            HStack(alignment: .bottom){
                                Text("Collectible Minifigures") // 홀수 번 테마 이름
                                    .font(.title2)
                                    .bold()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 22))
                                    .foregroundColor(.gray)
                                Spacer()
                            }.padding(.leading, textLeftedge)
                            Spacer()
                            Carousel(data: items, itemWidth: 55, activeID: $scrolledID) { item, isFocused in
                                MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused)
                            } // 미니 피규어 정보 수정 필요
                            Spacer(minLength: 10)
                        }.frame(width: 393, height: 180)
                    }
                }
                .navigationBarTitle("Minifigures")
                .navigationSplitViewStyle(.automatic)
                .padding()
            }
        }
    }
}

#Preview {
    MinifigureTabView()
}
