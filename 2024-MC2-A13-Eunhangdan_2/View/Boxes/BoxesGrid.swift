//
//  MariView.swift
//  Mari
//
//  Created by yoomin on 5/19/24.
//

import SwiftUI

struct BoxesGrid: View {
    

    
    // View 안에서의 상태 체크 인자 (Bool)
    
    let layoutImgStrings: [[String]]    // 2차원 배열 'layoutImgStrings' 선언
    var spacing: CGFloat
    
    init(imgStrings: [String], spacing: CGFloat = 2) {    // CGFloat: 32비트에서는 Float, 64비트에서는 Double로 처리함
        var layoutImgStrings = [[String]]()
        var tmp = [String]() // 빈 문자열 배열 'tmp' 선언
        
        // layoutImgStrings에 imgStrings 요소 집어넣기
        for img in imgStrings {
            tmp.append(img)    // img 변수를 tmp 배열에 추가하기
            if tmp.count >= 6 {    // tmp 배열의 요소가 2개 이상이 되면 블록 실행
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
        
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false) {
                VStack(spacing: spacing) {
                    let viewWidth: CGFloat = reader.size.width
                    
                    ForEach(layoutImgStrings.indices, id: \.self) { i in    // indices: 내가 읽고 있는 배열의 모든 인덱스를 포함
                        let imgStrings = layoutImgStrings[i]
                        if i % 3 != 2 || imgStrings.count < 3 {
                              Layout1(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing)
                        } else{
                            if i % 2 == 0 {
                                Layout2(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing)
                            } else {
                                Layout3(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing)
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
    }
    
    
}


// Main Grid Layout
struct Layout1: View {
    
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let height: CGFloat = (viewWidth - (2 * spacing)) / 2
        
        return HStack(spacing: spacing) {
            ForEach(imgStrings, id: \.self) {  imgStrings in
                Image(imgStrings)
                    .resizable()
                    .frame(width: height, height: height)
                    .scaledToFit()
            }
        }
        .frame(width: viewWidth, height: height, alignment: .center)
    }
}

// Layout 2 -> 경우를 나눠서 두가지 모양이 번갈아 나오게 하기
struct Layout2: View {
    
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        
        return HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                Image(imgStrings[0])
                    .resizable()
                    .frame(width: smallItemWidth, height: smallItemWidth)
                    .scaledToFit()
                Image(imgStrings[1])
                    .resizable()
                    .frame(width: smallItemWidth, height: smallItemWidth)
                    .scaledToFit()
            }
            Image(imgStrings[2])
                .resizable()
                .frame(width: height, height: height)
                .scaledToFit()
        }
        .frame(height: height)
        
    }
}

// Layout 2 -> 경우를 나눠서 두가지 모양이 번갈아 나오게 하기
struct Layout3: View {
    
    let imgStrings: [String]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        
        return HStack(spacing: spacing) {
            Image(imgStrings[2])
                .resizable()
                .frame(width: height, height: height)
                .scaledToFit()
            VStack(spacing: spacing) {
                Image(imgStrings[0])
                    .resizable()
                    .frame(width: smallItemWidth, height: smallItemWidth)
                    .scaledToFit()
                Image(imgStrings[1])
                    .resizable()
                    .frame(width: smallItemWidth, height: smallItemWidth)
                    .scaledToFit()
            }
        }
        .frame(height: height)
        
    }
}


#Preview {
    BoxesView()
}


