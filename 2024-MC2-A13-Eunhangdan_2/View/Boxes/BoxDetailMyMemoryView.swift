//
//  BoxDetailMyMemoryView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI
import PhotosUI

struct BoxDetailMyMemoryView: View {
    @Environment (\.modelContext) private var modelContext
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    var brickSet: BrickSet
    
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
                    ForEach(0..<selectedImages.count, id: \.self) { myMemory in
                        selectedImages[myMemory]
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
            .onDisappear(perform: {
                for img in selectedItems {
                    // Image를 Data 타입으로 변환해서 BrickSet의 photo에 저장
                    // brickSet.photos.append(ModelSchemaV1.Photo.init(photo:  ))
                    
                    
                }
                do {
                    modelContext.insert(brickSet)
                    try modelContext.save()
                } catch {
                    print("Error: failed to save photos in SwiftData")
                }
            })
        }
    }
    
   
}

#Preview {
    BoxDetailMyMemoryView(brickSet: BrickSet(setID: "bio001", theme: "", subtheme: "", setName: "해골 레고", pieces: 0, isAssembled: true, price: 0.0, setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
}
