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
    @ViewBuilder var content: (Items.Element, Bool) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(data) { item in
                            let isFocused = isItemFocused(item)
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
    @ViewBuilder var content: (Items.Element, Bool) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(data) { item in
                            let isFocused = isItemFocused(item)
                            content(item, isFocused)
                                .frame(width: itemWidth)
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
                .frame(width: 74, height: 104)
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


#Preview {
    MinifigureTabView()
}
