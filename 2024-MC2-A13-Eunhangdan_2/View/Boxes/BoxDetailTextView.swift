//
//  BoxDetailTextView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI

struct BoxDetailTextView: View {
    
    let brickSet: BrickSet
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Image(brickSet.setID)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 346)
                
                Spacer()
                    .frame(height: 32)
                
                Button(action: {
                    // 버튼이 눌렸을 때 실행될 코드
                }) {
                    Text("\(brickSet.theme)")
                        .textCase(.uppercase)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .underline()
                }
                Spacer()
                    .frame(height: 14)
                
                Text("\(brickSet.setName)")
                    .font(.title.weight(.semibold))
                
                Spacer()
                    .frame(height: 10)
                HStack{
                    Text("Sale Date:")
                        .foregroundColor(.gray)
                    Text("2002.4.23 - 2003.12.31")
                        .font(.subheadline)
                }
                HStack{
                    Text("Sale Price:")
                        .foregroundColor(.gray)
                    Text("$\(brickSet.price)")
                        .font(.subheadline)
                }
                HStack{
                    Text("Bricks:")
                        .foregroundColor(.gray)
                    Text("\(brickSet.pieces)")
                        .font(.subheadline)
                }
                Spacer()
                    .frame(height: 30)
                
                Divider()
                Spacer()
                    .frame(height: 30)
                
                Text("Minifigure")
                    .font(.title2.weight(.bold))
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 30) {
                        ForEach(brickSet.minifigureIdList, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(height: 90)}
                    }
                }.padding(.horizontal)
                Spacer()
                    .frame(height: 32)
                Divider()
            }
            
        }.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack() {
        BoxDetailTextView(brickSet:
                            BrickSet(setID: "bio001", theme: "무적 시리즈", subtheme: "", setName: "해골 레고", pieces: 0, isAssembled: true, price: 0.0, setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0)
        )

    }
    
}
