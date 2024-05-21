//
//  BoxesView.swift
//  Mari
//
//  Created by yoomin on 5/20/24.
//

import SwiftUI

struct BoxesView: View {
    let imgStrings = [
        "image1","image2","image3","image4","image5","image6","image7","image8","image9","image10","image11","image12","image13","image14"
    ]
 
    
    var body: some View {
        NavigationStack {
            Divider()
            
            BoxesGrid(imgStrings: imgStrings, spacing: 2)
            
        }
        .navigationTitle("Boxes")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // 필터 버튼
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundColor(.red)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                // 레고등록/미니피규어 등록 -> Collection 추가화면으로 이동
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.red)
                })
            }
            
        }
    }
}


// PreView
struct BoxesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BoxesView()
        }
    }
}
