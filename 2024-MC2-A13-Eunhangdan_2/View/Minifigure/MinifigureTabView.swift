//
//  MinifigureTabView.swift
//  EunhaengdanVol1
//
//  Created by lovehyun95 on 5/20/24.
//

import SwiftUI
import SwiftData


struct MinifigureTabView: View {
    
    @State var scrolledID: UUID?
    @State var showMinifigureModal = false
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \Minifig.themeCategory) var minifigs: [Minifig]
    @State var themeArray: [String] = []
    @State var themeFilteredMinifigs: [[Minifig]] = []
    @State var forCaroucel: [[minifigureItem]] = []
    @State var subThemeArray: [String: String] = [:]
    @State var villageImage: [villageItem] = [
        .init(villageImageString: "Village", villageBackGroundColor: .yellow),
        .init(villageImageString: "Village", villageBackGroundColor: .blue),
        .init(villageImageString: "Village", villageBackGroundColor: .mint),
        .init(villageImageString: "Village", villageBackGroundColor: .cyan),
        .init(villageImageString: "Village", villageBackGroundColor: .green),
        .init(villageImageString: "Village", villageBackGroundColor: .brown)
    ]
    
    let textLeftedge : CGFloat = 30
    var body: some View {
        NavigationStack(){
            ScrollView{
                VStack{
                    HStack(alignment: .bottom){
                        Text("My LEGO Village")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }.padding(.leading, textLeftedge)
                    ZStack{
                        villageCarousel(data: villageImage, itemWidth: 315, activeID: $scrolledID, showMinifigureModal: $showMinifigureModal){item, isFocused  in
                            VillageView(villageImageString: item.villageImageString, villageBackGroundColor: item.villageBackGroundColor)
                        }
                    }.frame(width: 375,height: 245)
                    Spacer(minLength: 30)
                    
                    ForEach(Array(themeArray.enumerated()) , id: \.offset){ index, theme in
                        ZStack{
                            if (theme.hashValue % 2 == 0){
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 393, height: 207)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.13), radius: 7.40)
                            }
                            VStack{
                                Spacer(minLength: 10)
                                HStack(alignment: .bottom){
                                    NavigationLink(destination: MinifigureListView(showMinifigureModal: $showMinifigureModal, minifigures: $forCaroucel[index])){
                                        Text("\(theme)")
                                            .font(.title2)
                                            .bold()
                                            .tint(.black)
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 22))
                                            .foregroundColor(.gray)
                                    }
                                    Button(action: {
                                        
                                    }, label: {
                                        
                                    })
                                    .sheet(isPresented: self.$showMinifigureModal, content: {
                                        MinifigureModalView(minifigID: "")
                                            .presentationDetents([.medium])
                                            .presentationDragIndicator(.visible)
                                    })
                                    Spacer()
                                }.padding(.leading, textLeftedge)
                                Carousel(minifigureImages: forCaroucel[index], itemWidth: 55.5, itemHeight: 104, activeID: $scrolledID, showMinifigureModal: $showMinifigureModal) { item, isFocused in
                                    MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused, legoHeight: 104)
                                }
                                Spacer(minLength: 10)
                            }.frame(width: 393, height: 180)
                        }
                    }
                }
                .navigationBarTitle("Minifigures")
                .navigationSplitViewStyle(.automatic)
                .padding()
            }
        }
        //MARK: - 테마, 피규어 ID, 부제목 분리하는 파트
        .onAppear() {
            var themeArray: [String] = []
            minifigs.forEach {
                themeArray.append($0.splitCategory[0])
            }
            let noDuplicateTheme = Set(themeArray)
            self.themeArray = Array(noDuplicateTheme).sorted()

            for theme in self.themeArray {
                let filteredMinifigs = minifigs.filter {
                    $0.splitCategory[0] == theme
                }
                themeFilteredMinifigs.append(filteredMinifigs)
            }
            for oneThemeMinifigArray in themeFilteredMinifigs {
                let arr = oneThemeMinifigArray.map{
                    return minifigureItem(minifigureImage: $0.minifigID, minifigureSubTheme: $0.splitCategory[1], minifigureTheme: $0.splitCategory[0])
                }
                forCaroucel.append(arr)
            }
            
        }
    }
}

//
//
#Preview {
    MinifigureView(minifigureImage: "", legoHeight: 103)
}
