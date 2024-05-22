//
//  BoxDetailMyMemoryView.swift
//  EunhaengdanVol1
//
//  Created by kyunglimkim on 5/21/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct BoxDetailMyMemoryView: View {
    @Environment (\.modelContext) private var modelContext
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @State private var selectedImage: UIImage?
    @State private var showCamera = false
    
    var brickSet: BrickSet
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Memory")
                        .font(.title2.weight(.bold))
                    
                    Spacer()
                    
                    //MARK: - 카메라 버튼 디자인 필요
                    Button("Open camera") {
                        self.showCamera.toggle()
                    }
                    .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                    }
                    
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
                    if let img = selectedImage {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    
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
                        // 화면 표시용 이미지로 배열에 저장
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                        // Data로 변환 후 SwiftData에 저장
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            brickSet.photos.append(ModelSchemaV1.Photo(photo: data))
                            do{
                                modelContext.insert(brickSet)
                                try modelContext.save()
                            } catch {
                                print("Error: failed to save photo")
                            }
                        }
                    }
                }
            }
            // 사진 찍고 데이터가 변경되었을 때, 화면에 표시 및 저장
            .onChange(of: selectedImage) { before ,newImage in
                guard let newImage = newImage else { return }
                // 화면 표시
                selectedImages.append(Image(uiImage: newImage))
                // DB 저장
                if let data = newImage.jpegData(compressionQuality: 1.0) {
                    brickSet.photos.append(ModelSchemaV1.Photo(photo: data))
                    do {
                        modelContext.insert(brickSet)
                        try modelContext.save()
                    } catch {
                        print("Error: failed to save photo from camera")
                    }
                }
            }
        }
    }
}
// 카메라 뷰
struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}


#Preview {
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
    
    return BoxDetailMyMemoryView(brickSet: BrickSet(setID: "bio001", theme: "", subtheme: "", setName: "해골 레고", pieces: 0, isAssembled: true, price: 0.0, setImageURL: "", isFavorite: true, isOwned: true, photos: [], purchaseDate: Date(), releasedDate: 0))
        .modelContainer(container)
}
