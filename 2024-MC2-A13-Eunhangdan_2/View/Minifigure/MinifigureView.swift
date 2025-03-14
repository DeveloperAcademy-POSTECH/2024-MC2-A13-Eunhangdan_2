//
//  MinifigureView.swift
//  EunhaengdanVol1
//
//  Created by lovehyun95 on 5/20/24.
//


import SwiftUI
import SwiftData
//MARK: - 임시로 사용할 Struct 구현부
struct MinifigureItem: Identifiable {
    let id: UUID = .init()
    var minifigureImage: String
    var minifigureSubTheme: String
    var minifigureTheme: String
    var minifigureName: String
    var minifigureIncludeSetId: [String]
    var minifigureCreatedDate: Date
}
struct VillageItem: Identifiable {
    let id: UUID = .init()
    var villageImageString: String
    var villageBackGroundColor : Color
}

//MARK: - Carousel 구현부
struct Carousel<Content: View, minifigImages: RandomAccessCollection>: View where minifigImages.Element: Identifiable {
    var minifigureImages: minifigImages
    var itemWidth: CGFloat
    var itemHeight: CGFloat
    
    @Binding var selectedSubDetailIndex: Int
    
    @Binding var activeID: UUID?
    @Binding var selectedMinifigItem : MinifigureItem
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
                                    print("1 :: mart minifigure selected")
                                    selectedMinifigItem = image as! MinifigureItem
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
                                    print("2 :: mart minifigure selected")
                                    selectedMinifigItem = image as! MinifigureItem
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
struct VillageCarousel<Content: View, Items: RandomAccessCollection>: View where Items.Element: Identifiable {
    var data: Items
    var itemWidth: CGFloat
    @Binding var activeID: UUID?
    @Binding var showMinifigureModal: Bool
    @ViewBuilder var content: (Items.Element, Bool, Int) -> Content
   
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                            let isFocused = isItemFocused(item)
                            Button(action: {
                                
                            }, label: {
                                content(item, isFocused, index)
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
    @Binding var selectedSubDetailIndex: Int
    
    var body: some View {
        if let imageExists = UIImage(named: "\(minifigureImage)") {
            Image(minifigureImage)
                .resizable()
                .font(.body)
                .scaledToFit()
                .bold(isFocused)
                .frame(height: legoHeight)
        } else {
            //TODO: getting Data and show as Image later
            AsyncImage(url: URL(string: "https://img.bricklink.com/ItemImage/MN/0/\(minifigureImage).png")) {image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                // Progress View
            }
            .bold(isFocused)
            .frame(height: legoHeight)
            .clipped()
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

//MARK: - 새로운 VillageView2 구현부
struct VillageView2: View{
    var villageImageString: String
    var villageBackGroundColor : Color // 불필요하지만 1, 2 선택을 쉽게 하기 위해서 통일
    
    var body: some View{
        HStack{
                Image(villageImageString)
                    .resizable()
                    .frame(width: 330, height: 226)
                    .cornerRadius(12.0)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 5, y: 1)
        }
    }
}

//MARK: - Minifigure Modal View 구현부
struct MinifigureModalView: View{
    @Binding var minifigureForDetail : MinifigureItem
    @State var minifigureIncludeSetID: [String] = []
    var subThemeIndex: Int
    var body: some View {
        VStack{
            Spacer(minLength: 40)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(){
                    Text("\(minifigureForDetail.minifigureName)")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 16)
                        .padding(.top, 16)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                }
            }
            Spacer(minLength: 25)
            HStack(){
                Spacer(minLength: 24)
                
                if let imageExists = UIImage(named: "\(minifigureForDetail.minifigureImage)") {
                    Image("\(minifigureForDetail.minifigureImage)")
                        .resizable()
                        .scaledToFit()
                        .minimumScaleFactor(0.001)
                        .frame(height: 131)
                } else {
                    //TODO: getting Data and show as Image later
                    AsyncImage(url: URL(string: "https://img.bricklink.com/ItemImage/MN/0/\(minifigureForDetail.minifigureImage).png")) {image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // Progress View
                    }
                    .minimumScaleFactor(0.001)
                    .frame(height: 131)
                    .clipped()
                }
                
                
                Spacer(minLength: 28)
                VStack{
                    HStack(){
                        Text("\(minifigureForDetail.minifigureTheme)")
                            .font(.title3)
                            .bold()
                            .minimumScaleFactor(0.001)
                            .padding(.bottom, 22)
                    }
                    HStack(){
                        Text("Num:  ")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("\(minifigureForDetail.minifigureImage)")
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                    HStack(){
                        Text("SubTheme:")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("\(minifigureForDetail.minifigureSubTheme)")
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .padding(.horizontal)
                    }
                    HStack(alignment: .top) {
                        Text("Date: ")
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("\(minifigureForDetail.minifigureCreatedDate.formatted(date: .abbreviated, time: .omitted))")
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
            ZStack()
            {
                Rectangle()
                    .fill(Color(.gray).opacity(0.3))
                    .frame(width: 393, height: 200)
                    .blur(radius: 18)
                ScrollView(.horizontal){
                    HStack(){
                        ForEach(minifigureIncludeSetID.indices, id: \.self) { index in
                            Button {
                                
                            } label: {
                                Image(minifigureIncludeSetID[index])
                                    .padding(.horizontal, 20)
                                    .frame(height: 190)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 7)
                                Spacer()
                            }
                        }
                    }
                }
            }
            Spacer()
        }.onAppear {
            self.minifigureIncludeSetID = minifigureForDetail.minifigureIncludeSetId
        }
    }
}
// MARK: - Minifigure List View 구현부
struct MinifigureListView: View {
    @State var scrolledID: UUID?
    @State var subthemeFilteredMinifigs: [[MinifigureItem]] = []
    @State var subThemeArray: [String] = []
    @State var filteredSubThemeArrayInSubTheme: [[MinifigureItem]] = []
    
    @Binding var selectedSubDetailIndex: Int
    @Binding var selectedMinifigItem: MinifigureItem
    @Binding var showMinifigureModal: Bool
    @Binding var minifigures: [MinifigureItem]
    
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
                                destination: MinifigureShelfView(minifigures: $subthemeFilteredMinifigs[index],selectedMinifigItem: $selectedMinifigItem, showMinifigureModal: $showMinifigureModal)
                            ){
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
                                Carousel(minifigureImages: subthemeFilteredMinifigs[index], itemWidth: 57, itemHeight: 202, selectedSubDetailIndex: $selectedSubDetailIndex, activeID: $scrolledID, selectedMinifigItem: $selectedMinifigItem, showMinifigureModal: $showMinifigureModal) { item, isFocused in
                                    MinifigureView(minifigureImage: item.minifigureImage, isFocused: isFocused, legoHeight: 170, selectedSubDetailIndex: $selectedSubDetailIndex)
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
    @Binding var minifigures: [MinifigureItem]
    @Binding var selectedMinifigItem : MinifigureItem
    @Binding var showMinifigureModal: Bool
    var itemHeight: CGFloat = 104
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        ScrollView {
            VStack{
                Spacer(minLength: 40)
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
                                        print("3 :: mart minifigure selected")
                                        selectedMinifigItem = minifigures[index]
                                        showMinifigureModal = true
                                    }, label: {
                                        VStack{
                                            //여기
                                            if let imageExists = UIImage(named: "\(minifigures[index].minifigureImage)") {
                                                Image(minifigures[index].minifigureImage)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: itemHeight)
                                            } else {
                                                AsyncImage(url: URL(string: "https://img.bricklink.com/ItemImage/MN/0/\(minifigures[index].minifigureImage).png")) {image in
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                } placeholder: {
                                                    // Progress View
                                                }
                                                .minimumScaleFactor(0.001)
                                                .frame(height: itemHeight)
                                                .clipped()
                                            }
                                            
                                            
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("\(minifigures[0].minifigureSubTheme)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    MinifigureTabView()
}
