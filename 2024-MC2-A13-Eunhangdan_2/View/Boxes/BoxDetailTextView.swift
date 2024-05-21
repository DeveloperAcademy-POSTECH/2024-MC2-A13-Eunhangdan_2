//
//  BoxDetailTextView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI

struct BoxDetailTextView: View {
    
    let images = ["legoex1", "legoex2", "legoex3"]
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Image("boximage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 346)
                
                Spacer()
                    .frame(height: 32)
                
                Button(action: {
                    // 버튼이 눌렸을 때 실행될 코드
                }) {
                    Text("lego series name plz")
                        .textCase(.uppercase)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .underline()
                }
                Spacer()
                    .frame(height: 14)
                
                Text("Bounty Hunter PURSUIT")
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
                    Text("$30")
                        .font(.subheadline)
                }
                HStack{
                    Text("Bricks:")
                        .foregroundColor(.gray)
                    Text("259")
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
                        ForEach(images, id: \.self) { imageName in
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
        BoxDetailTextView()
    }
    
}
