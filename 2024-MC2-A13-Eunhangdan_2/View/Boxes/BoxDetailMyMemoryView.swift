//
//  BoxDetailMyMemoryView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI
import PhotosUI

struct BoxDetailMyMemoryView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Memory")
                        .font(.title2.weight(.bold))
                    Spacer()
                    PhotosPicker(
                        selection: $selectedItems,
                        matching: .images
                    ) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                            .bold()
                    }
                }
                .padding()
                LazyVStack {
                    ForEach(0..<selectedImages.count, id: \.self) { mymemory in
                        selectedImages[mymemory]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 321)
                    }
                }
                
                
            }
            .onChange(of: selectedItems) {
                Task {
                    selectedImages.removeAll()
                    
                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BoxDetailMyMemoryView()
}
