//
//  MariView.swift
//  Mari
//
//  Created by yoomin on 5/19/24.
//
// Andrew 추가 작업
// 1. SwiftData에서 데이터 불러오기

import SwiftUI
import SwiftData

struct BoxesGrid: View {

    let layoutImgStrings: [[String]]    // 2차원 배열 'layoutImgStrings' 선언
    var spacing: CGFloat
    
    init(imgStrings: [String], spacing: CGFloat = 3) {    // CGFloat: 32비트에서는 Float, 64비트에서는 Double로 처리함
        var layoutImgStrings = [[String]]()
        var tmp = [String]() // 빈 문자열 배열 'tmp' 선언
        
        // layoutImgStrings에 imgStrings 요소 집어넣기
        for imgString in imgStrings {
            tmp.append(imgString)    // img 변수를 tmp 배열에 추가하기
            if tmp.count >= 7 {    // tmp 배열의 요소가 7개 이상이 되면 블록 실행
                layoutImgStrings.append(tmp)    // tmp 배열을 layoutImgStrings에 추가
                tmp.removeAll()    // tmp 배열 초기화
            }
        }
        
        // 남은 요소 추가
        if !tmp.isEmpty {
            layoutImgStrings.append(tmp)
        }
        
        self.layoutImgStrings = layoutImgStrings
        self.spacing = spacing
        
    }  // init
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false) {
                Divider()
                VStack(spacing: spacing) {
                    let viewWidth: CGFloat = reader.size.width
                    
                    ForEach(layoutImgStrings.indices, id: \.self) { i in    // indices: 내가 읽고 있는 배열의 모든 인덱스를 포함
                        let imgStrings = layoutImgStrings[i]
                        // 7개 미만으로 남은 배열 요소에 대한 처리
                        if imgStrings.count < 7 {
                            // 2개씩 넣고, 마지막에는 1개 or 2개
                            ForEach(0..<imgStrings.count, id: \.self) { index in
                                if index % 2 == 0 {
                                    let endIndex = min(index + 1, imgStrings.count - 1)
                                    Layout1(imgStrings: Array(imgStrings[index...endIndex]), viewWidth: viewWidth, spacing: spacing)
                                }
                            }
                        } else {
                            // 0 ~ 3번 요소
                            Layout1(imgStrings: Array(imgStrings[0...1]), viewWidth: viewWidth, spacing: spacing)
                            Layout1(imgStrings: Array(imgStrings[2...3]), viewWidth: viewWidth, spacing: spacing)
                            if i % 2 == 0 {
                                // 짝수일 때, 4 ~ 7번 요소
                                Layout2(imgStrings: Array(imgStrings[4...6]), viewWidth: viewWidth, spacing: spacing)
                            } else {
                                // 홀수일 때, 4 ~ 7번 요소
                                Layout3(imgStrings: Array(imgStrings[4...6]), viewWidth: viewWidth, spacing: spacing)
                            }
                        }
                    }  // ForEach
                    
                }  // VStack
            }  // ScrollView
        }  // GeometryReader
        .background(Material.thick)
        
    }
    
    
}  // BoxesGrid


// Main Grid Layout
struct Layout1: View {
    
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let height: CGFloat = (viewWidth - (2 * spacing)) / 2.05
        
        return HStack(spacing: spacing) {
            ForEach(imgStrings, id: \.self) {  imgString in
                NavigationImage(imgString: imgString, height: height)
            }
        }
        .frame(width: viewWidth, height: height, alignment: .center)
    }
}

// Layout 2
struct Layout2: View {
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3.1
        let height: CGFloat = smallItemWidth * 2 + spacing
        
        return HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                NavigationImage(imgString: imgStrings[0], height: smallItemWidth)
                NavigationImage(imgString: imgStrings[1], height: smallItemWidth)
            }
            NavigationImage(imgString: imgStrings[2], height: height)
        }
        .frame(height: height)
    }
}

// Layout 3
struct Layout3: View {
    
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3.1
        let height: CGFloat = smallItemWidth * 2 + spacing
        
        return HStack(spacing: spacing) {
            NavigationImage(imgString: imgStrings[2], height: height)
            VStack(spacing: spacing) {
                NavigationImage(imgString: imgStrings[0], height: smallItemWidth)
                NavigationImage(imgString: imgStrings[1], height: smallItemWidth)
            }
        }
    }
}

struct NavigationImage: View {
    let imgString: String
    let height: CGFloat
    
    var body: some View {
        NavigationLink(destination:{
            BoxDetailView(brickSetID: imgString)
        }) {
            Image(imgString)
                .resizable()
                .frame(width: height, height: height)
                .scaledToFit()
        }
    }
}

#Preview {
    let str = ["1374-1", "1376-1", "1737-1", "3423-1", "3425-2", "3431-1",
               "4475-1", "4478-1", "4484-1", "4488-1", "4489-1", "4490-1",
               "4500-1", "4566-1", "4567-1", "4568-1", "4569-1", "4570-1",
               "4571-1", "4572-1", "4573-1", "4593-1", "4607-1"]
    return BoxesGrid(imgStrings: str)
}


