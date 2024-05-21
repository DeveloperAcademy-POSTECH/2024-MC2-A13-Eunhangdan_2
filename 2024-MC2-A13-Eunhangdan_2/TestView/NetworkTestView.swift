//
//  NetworkTestView.swift
//  EunhaengdanVol1
//
//  Created by LDW on 5/17/24.
//

import SwiftUI

struct NetworkTestView: View {
    
    @State private var networkData: String = ""
    @State private var brickNumber: String = ""
    @State private var minifigNumber: String = ""
    @State private var setList: [BrickSetApiModel.Set] = []
    @State private var minifigList: [MinifigApiModel.Minifig] = []
    var networkManager = NetworkManager.shared
    
    var body: some View {
        TabView {
            VStack{
                HStack{
                    Text("BrickSet 검색 테스트")
                        .font(.title)
                    Spacer()
                }
                TextField("세트 품번을 입력하세요", text: $brickNumber)
                
                Button(action: {
                    if brickNumber == "" {return}
                    networkManager.fetchBrick(searchString: brickNumber) { result in
                        switch result {
                        case .success(let sets):
                            
                            setList.removeAll()
                            
                            for set in sets {
                                setList.append(set)
                                print("-----------------------------")
                                print("Set ID: \(set.setID)")
                                print("Name: \(set.name)")
                                print("Year: \(set.year)")
                                guard let pieces = set.pieces else { return }
                                print("Pieces: \(pieces)")
                                print("Minifigs: \(set.minifigs ?? 0)") // Optional 처리
                                print("Image URL: \(set.image.imageURL)")
                                print("-----------------------------")
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                        
                    }
                }, label: {
                    HStack{
                        Text("Get BrickSet Data")
                        Spacer()
                    }
                })
                
                ForEach(setList, id: \.setID) { set in
                    HStack{
                        // URL로 이미지 비동기 요청하기
                        AsyncImage(url: URL(string: set.image.imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 128, height: 128)
                        .clipShape(.rect(cornerRadius: 25))
                        Text("Set Name : \(set.name)")
                            .padding(.vertical, 16)
                        
                    }
                }
                
            }
            .tabItem {
                Text("BrickSet")
            }
            
            
            
            VStack{
                HStack{
                    Text("Minifig 검색 테스트")
                        .font(.title)
                    Spacer()
                }.padding(.top, 32)
                
                TextField("미니 피규어 품번을 입력하세요", text: $minifigNumber)
                
                Button(action: {
                    if minifigNumber == ""  {return}
                    networkManager.fetchMinifig(searchString: minifigNumber) { result in
                        switch result {
                        case .success(let minifigs):
                            
                            minifigList.removeAll()
                            
                            for minifig in minifigs {
                                minifigList.append(minifig)
                                print("-----------------------------")
                                print("Minifig NumberID: \(minifig.minifigNumber )")
                                print("Minifig Name : \(minifig.name)")
                                print("Minifig Category : \(minifig.category)")
                                print("-----------------------------")
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                        
                    }
                }, label: {
                    HStack{
                        Text("Get Minifig Data")
                        Spacer()
                    }
                })
                
                ForEach(minifigList, id: \.minifigNumber) { minifig in
                    HStack{
                        
                        Text("Minifig Name : \(minifig.name)")
                            .padding(.vertical, 16)
                        
                    }
                }
                
            }
            .tabItem {
                Text("Minifig")
            }
        }
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    NetworkTestView()
}
