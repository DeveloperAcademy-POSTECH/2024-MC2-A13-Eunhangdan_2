//
//  MinifigureView.swift
//  EunhaengdanVol1
//
//  Created by lovehyun95 on 5/20/24.
//


import SwiftUI
import SwiftData
//MARK: - 임시로 사용할 Struct 구현부
struct minifigureItem: Identifiable {
    let id: UUID = .init()
    var minifigureImage: String
    var minifigureSubTheme: String
    var minifigureTheme: String
}
struct villageItem: Identifiable {
    let id: UUID = .init()
    var villageImageString: String
    var villageBackGroundColor : Color
}
//MARK: - Carousel 구현부
struct Carousel<Content: View, minifigImages: RandomAccessCollection>: View where minifigImages.Element: Identifiable {
    var minifigureImages: minifigImages
    var itemWidth: CGFloat
    var itemHeight: CGFloat
    @Binding var activeID: UUID?
    @Binding var showMinifigureModal: Bool
    @ViewBuilder var content: (minifigImages.Element, Bool) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                if (itemWidth >= 100) {
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center) {
                            ForEach(minifigureImages) { image in
                                let isFocused = isItemFocused(image)
                                Button(action: {
                                    showMinifigureModal = true
                                }, label: {
                                    content(image, isFocused)
                                        .frame(height: itemHeight)
                                        .scaledToFit()
                                        .scrollTransition { content, phase in
                                            content
                                                .scaleEffect(
                                                    x: determineScaleEffect(phase.isIdentity),
                                                    y: determineScaleEffect(phase.isIdentity)
                                                )
                                        }
                                })
                            }
                            .padding(10)
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal,  (size.width - (itemWidth * 3.76)))
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $activeID, anchor: .center)
                }else{
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center) {
                            ForEach(minifigureImages) { image in
                                let isFocused = isItemFocused(image)
                                Button(action: {
                                    showMinifigureModal = true
                                }, label: {
                                    content(image, isFocused)
                                        .scaledToFit()
                                        .frame(height: itemHeight)
                                        .scrollTransition { content, phase in
                                            content
                                                .scaleEffect(
                                                    x: determineScaleEffect(phase.isIdentity),
                                                    y: determineScaleEffect(phase.isIdentity)
                                                )
                                        }
                                })
                            }
                            .padding(10)
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal,  (size.width - (itemWidth * 6.7)))
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $activeID, anchor: .center)
                    
                }
                
            }
        }
    }
    private func determineScaleEffect(_ isIdentity: Bool) -> Double {
        let scalePoint = 1.0
        let scaleDefault = 1.0
        return isIdentity ? scalePoint : scaleDefault
    }
    private func isItemFocused(_ item: minifigImages.Element) -> Bool {
        return item.id == activeID as? minifigImages.Element.ID
    }
}
//MARK: - village Carousel 구현부
struct villageCarousel<Content: View, Items: RandomAccessCollection>: View where Items.Element: Identifiable {
    var data: Items
    var itemWidth: CGFloat
    @Binding var activeID: UUID?
    @Binding var showMinifigureModal: Bool
    @ViewBuilder var content: (Items.Element, Bool) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(data) { item in
                            let isFocused = isItemFocused(item)
                            Button(action: {
                                
                            }, label: {
                                content(item, isFocused)
                                    .frame(width: itemWidth)
                            })
                            
                        }
                        .padding(10)
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, (size.width - itemWidth) / 2 - 10)
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeID, anchor: .center)
            }
        }
    }
    private func isItemFocused(_ item: Items.Element) -> Bool {
        return item.id == activeID as? Items.Element.ID
    }
}
//MARK: - Minifigure View 구현부
struct MinifigureView: View {
    var minifigureImage: String
    var isFocused: Bool = false
    var legoHeight: CGFloat
    
    var body: some View {
        VStack {
            Image(minifigureImage)
                .resizable()
                .font(.body)
                .scaledToFit()
                .bold(isFocused)
                .frame(height: legoHeight)
        }
    }
}
//MARK: - VillageView 구현부
struct VillageView: View{
    var villageImageString: String
    var villageBackGroundColor : Color
    
    var body: some View{
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(AngularGradient(gradient: Gradient(colors: [Color.white, Color(villageBackGroundColor)]),
                                          center: .topLeading,
                                          angle: .degrees(120))
                    )
                    .frame(width: 330, height: 226)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 5, y: 1)
                Image(villageImageString)
                    .resizable()
                    .frame(width: 266, height: 216)
            }
        }
    }
}

//MARK: - Minifigure Modal View 구현부
struct MinifigureModalView: View{
    let minifigID: String

    var body: some View {
        VStack{
            Spacer(minLength: 16.5)
            HStack(){
                Text("")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 16)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer(minLength: 25)
            HStack(){
                Spacer(minLength: 24)
                Image("avt011")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 131)
                Spacer(minLength: 28)
                VStack{
                    HStack(){
                        Text("Herry Poter")
                            .font(.title3)
                            .padding(.bottom, 22)
                        Spacer()
                    }
                    HStack(){
                        Text("Pro.Num:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("Herry Poter")
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                    HStack(){
                        Text("Pro.Name:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("Herry Poter")
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                    HStack(){
                        Text("Release Date:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("Herry Poter")
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
            }
            Spacer()
            HStack(){
                Text("Series")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 16)
                    .padding(.top, 16.5)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Rectangle()
                .fill(Color(.gray).opacity(0.3))
                .frame(width: 393, height: 156)
        }
    }
}
// MARK: - Minifigure List View 구현부
struct MinifigureListView: View {
    @State var scrolledID: UUID?
    @Binding var showMinifigureModal: Bool
    @Binding var minifigures: [minifigureItem]
    @State var subthemeFilteredMinifigs: [[minifigureItem]] = []
    @State var subThemeArray: [String] = []
    var body: some View {
        ScrollView(){
            ForEach(subThemeArray.indices, id: \.self){ index in
                let subTheme = subThemeArray[index]
                ZStack(){
                    if index % 2 == 0{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 393, height: 180)
                            .offset(x: 0, y: 0)
                    }
                    VStack(){
                        HStack(){
                            NavigationLink(
                                destination: MinifigureShelfView(minifigures: $subthemeFilteredMinifigs[index], showMinifigureModal: $showMinifigureModal)){
                                    Text("\(subTheme)")
                                        .font(.title2)
                                        .bold()
                                        .tint(.black)
                                        .padding(.leading, 20)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 22))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }.padding(.bottom, 0)
                        }
                        ZStack(){
                            Image("shelf")
                                .resizable()
                                .frame(width: 393, height: 60)
                                .offset(x: 2, y: 110.0)
                            HStack(){
                                Carousel(minifigureImages: subthemeFilteredMinifigs[index], itemWidth: 57, itemHeight: 202, activeID: $scrolledID, showMinifigureModal: $showMinifigureModal) { item, isFocused in
                                    MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused, legoHeight: 170)
                                }
                            }.frame(width: 393, height: 180)
                        }
                        Spacer(minLength: 40)
                    }
                }
            }
            .padding(.top, 20)
        }
        .navigationTitle(minifigures.first?.minifigureTheme ?? "Default Title")
        .navigationSplitViewStyle(.automatic)
        .onAppear() {
            var subThemeArray: [String] = []
            minifigures.forEach {
                subThemeArray.append($0.minifigureSubTheme)
            }
            let noDuplicateTheme = Set(subThemeArray)
            self.subThemeArray = Array(noDuplicateTheme).sorted()
            
            for subTheme in self.subThemeArray {
                let filteredMinifigs = minifigures.filter {
                    $0.minifigureSubTheme == subTheme
                }
                subthemeFilteredMinifigs.append(filteredMinifigs)
            }
        }
    }
}
//MARK: - Minifigure Shelf View 구현부
struct MinifigureShelfView: View{
    @Binding var minifigures: [minifigureItem]
    @Binding var showMinifigureModal: Bool
    var itemHeight: CGFloat = 104
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        ScrollView {
            VStack{
                ZStack{
                    LazyVGrid(columns: columns, spacing: 22) {
                        ForEach(minifigures.indices, id: \.self) { index in
                            ZStack(){
                                if index % 4 == 0 {
                                    Image("shelf")
                                        .resizable()
                                        .frame(width: 393, height: 50)
                                        .offset(x: 151, y: 75)
                                }
                                HStack{
                                    Button(action: {
                                        showMinifigureModal = true
                                    }, label: {
                                        VStack{
                                            Image(minifigures[index].minifigureImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: itemHeight)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("String")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MinifigureTabView()
}
