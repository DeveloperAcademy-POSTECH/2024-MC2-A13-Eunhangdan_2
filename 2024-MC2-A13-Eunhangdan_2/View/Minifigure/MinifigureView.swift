//
//  MinifigureView.swift
//  EunhaengdanVol1
//
//  Created by lovehyun95 on 5/20/24.
//


import SwiftUI
//MARK: - 임시로 사용할 Struct 구현부
struct minifigureItem: Identifiable {
    let id: UUID = .init()
    var minifigureImage: String
}
struct villageItem: Identifiable {
    let id: UUID = .init()
    var villageImageString: String
    var villageBackGroundColor : Color
}
//MARK: - 캐러셀 구현부
struct Carousel<Content: View, Items: RandomAccessCollection>: View where Items.Element: Identifiable {
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
                                showMinifigureModal = true
                            }, label: {
                                content(item, isFocused)
                                    .frame(width: itemWidth)
                                // .border(.black, width: 1)
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
    private func determineScaleEffect(_ isIdentity: Bool) -> Double {
        let scalePoint = 1.0
        let scaleDefault = 1.0
        return isIdentity ? scalePoint : scaleDefault
    }
    private func isItemFocused(_ item: Items.Element) -> Bool {
        return item.id == activeID as? Items.Element.ID
    }
}
//MARK: - 빌리지 캐러셀 구현부
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
                            // 테마별로 클릭 시 해당 마을 꾸미기로 넘어감
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
//MARK: - MinifigureView 구현부
struct MinifigureView: View {
    var minifigureImage: String
    var isFocused: Bool = false
    
    var body: some View {
        VStack {
            Image(minifigureImage)
                .resizable()
                .font(.body)
                .bold(isFocused)
                .frame(width: 64, height: 104)
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

//MARK: - 미니피규어 모달 정보창 구현 뷰
struct MinifigureModalView: View{
    //to dismiss sheet
    
    var body: some View {
        VStack{
            Spacer(minLength: 16.5)
            HStack(){
                Text("Minifigure Detail")
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
                    .frame(width: 83, height: 131)
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

#Preview {
    MinifigureTabView()
}
