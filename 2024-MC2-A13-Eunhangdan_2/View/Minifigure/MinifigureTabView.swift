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
    @State var minifigItemsPerTheme: [[MinifigureItem]] = [] //
    @State var subThemeArray: [String: String] = [:]
    @State var villageImage: [VillageItem] = [
        .init(villageImageString: "village01", villageBackGroundColor: .yellow),
        .init(villageImageString: "village02", villageBackGroundColor: .blue),
        .init(villageImageString: "village03", villageBackGroundColor: .mint),
        .init(villageImageString: "village04", villageBackGroundColor: .cyan),
    ]
    @State var selectedDetailIndex: Int = 0 // 1차 배열
    
    @State var selectedMinifigItem: MinifigureItem = MinifigureItem(minifigureImage: "", minifigureSubTheme: "", minifigureTheme: "", minifigureName: "", minifigureIncludeSetId: [], minifigureCreatedDate: Date())
    
    @State private var villageList: [BrickVillege] = [
        BrickVillege(backgroundID: UUID(), backgroundName: "village01", categoryInfo: "Town", registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"], xCoordi:[100, 300, 200], yCoordi: [200, 500, 700], rotationDegree: [-15, -90, 25]),
        BrickVillege(backgroundID: UUID(), backgroundName: "village02", categoryInfo: "Town", registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"], xCoordi:[100, 300, 200], yCoordi: [200, 500, 700], rotationDegree: [-15, -90, 25]),
        BrickVillege(backgroundID: UUID(), backgroundName: "village03", categoryInfo: "Town", registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"], xCoordi:[100, 300, 200], yCoordi: [200, 500, 700], rotationDegree: [-15, -90, 25]),
        BrickVillege(backgroundID: UUID(), backgroundName: "village04", categoryInfo: "Town", registeredMinifigureID: ["whoAreYou", "whoAreYou", "whoAreYou"], xCoordi:[100, 300, 200], yCoordi: [200, 500, 700], rotationDegree: [-15, -90, 25])
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
                    
                    
                    villageCarousel(data: villageImage, itemWidth: 315, activeID: $scrolledID,
                                   // villages: $villageList,
                                    showMinifigureModal: $showMinifigureModal){item, isFocused, index  in
                        NavigationLink {
                            BrickVillageView(village: $villageList[index])
                        } label: {
                            VillageView2(villageImageString: item.villageImageString, villageBackGroundColor: item.villageBackGroundColor)
                        }
                    }.frame(width: 375,height: 245)
                    
                    Spacer(minLength: 30)
                    
                    ForEach(Array(themeArray.enumerated()) , id: \.offset){ index, theme in
                        ZStack{
                            if (index % 2 == 0){
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 393, height: 207)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.13), radius: 7.40)
                            }
                            VStack{
                                Spacer(minLength: 10)
                                
                                HStack(alignment: .bottom){
                                    NavigationLink(destination:
                                                    MinifigureListView(
                                                        selectedSubDetailIndex: $selectedDetailIndex,
                                                        selectedMinifigItem: $selectedMinifigItem,
                                                        showMinifigureModal: $showMinifigureModal,
                                                        minifigures: $minifigItemsPerTheme[index])
                                    ) {
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
                                        MinifigureModalView(minifigureForDetail: $selectedMinifigItem, subThemeIndex: selectedDetailIndex)
                                            .presentationDetents([.medium])
                                            .presentationDragIndicator(.hidden)
                                    })
                                    Spacer()
                                }.padding(.leading, textLeftedge)
                                
                                Carousel(minifigureImages: minifigItemsPerTheme[index], itemWidth: 55.5, itemHeight: 104, selectedSubDetailIndex: $selectedDetailIndex,activeID: $scrolledID, selectedMinifigItem: $selectedMinifigItem, showMinifigureModal: $showMinifigureModal) { item, isFocused in
                                    MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused, legoHeight: 104, selectedSubDetailIndex: $selectedDetailIndex)
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
                    return MinifigureItem(minifigureImage: $0.minifigID, minifigureSubTheme: $0.splitCategory[1], minifigureTheme: $0.splitCategory[0], minifigureName: $0.minifigName, minifigureIncludeSetId: $0.includedSetID, minifigureCreatedDate: $0.createdDate)
                }
                minifigItemsPerTheme.append(arr)
            }
        }
    }
}

//
//
#Preview {
    MinifigureTabView()
}
