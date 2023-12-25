//
//  FirebasePhotoPicker.swift
//  FirebasePhotoPicker
//
//  Created by Thibault Giraudon on 25/12/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI

struct FirebasePhotoPicker: View {
    @Environment(\.dismiss) private var dismiss
    @State private var imageURLs: [URL] = []
    @Binding var selectedImage: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(imageURLs, id: \.self) { imageURL in
                    Button {
                        selectedImage = imageURL.absoluteString
                        dismiss()
                    } label: {
                        WebImage(url: imageURL)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(3)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            fetchImagesFromFirebaseStorage()
        }
    }

    func fetchImagesFromFirebaseStorage() {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("landmarks")
        storageRef.listAll { (result, error) in
            if let error = error {
                    print("Error while listing all files: ", error)
            }

            if let items = result?.items {

                for item in items {
                    print("Item in images folder: ", item)
                    item.downloadURL { url, error in

                        if let url = url {
                            self.imageURLs.append(url)
                        } else if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
