//
//  BoxDetailTextView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI
import SwiftData

struct BoxDetailTextView: View {
    @Environment (\.modelContext) private var modelContext
    let brickSet: BrickSet
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                if UIImage(named: "\(brickSet.setID)") != nil {
                    Image(brickSet.setID)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 346)
                } else {
                    //TODO: getting Data and show as Image later
                    AsyncImage(url: URL(string: "https://images.brickset.com/sets/small/\(brickSet.setID)-1.jpg")) {image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // Progress View
                    }
                    .frame(width: 346)
                    .clipped()
                }
                
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
                    Text("Released Year:")
                        .foregroundColor(.gray)
                    
                    if brickSet.releasedDate == 0 {
                        Text("????")
                    } else {
                        Text("\(brickSet.releasedDate)".replacingOccurrences(of: ",", with: ""))
                            .font(.subheadline)
                    }
                }
                HStack{
                    Text("Sale Price:")
                        .foregroundColor(.gray)
                    Text("$\(String(format: "%.2f", brickSet.price))")
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
                        brickSet.isFavorite.toggle()
                    }) {
                        if brickSet.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onDisappear {
                do {
                    modelContext.insert(brickSet)
                    try modelContext.save()
                } catch {
                    print("Error: failed to save 'isFavorite' toggle")
                }
            }
    }
}

#Preview {
    NavigationStack() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container : ModelContainer = {
            let schema = Schema([
                BrickSet.self, Minifig.self, BrickVillege.self,
            ])

            do {
                return try ModelContainer(for: schema, configurations: config)
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        
        container.mainContext.insert(BrickSet(setID: "avt010", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "avt007", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "avt008", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "avt011", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "bio001", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "bio002", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        container.mainContext.insert(BrickSet(setID: "bio005", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        
        return BoxDetailTextView(brickSet: BrickSet(setID: "bio005", theme: "", subtheme: "", setName: "", pieces: 0, isAssembled: true, price: 0.0, minifigureIdList: [], setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
            .modelContainer(container)

    }
    
}
