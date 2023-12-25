//
//  ContentView.swift
//  FirebasePhotoPicker
//
//  Created by Thibault Giraudon on 25/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var selectedPhoto = ""
    @State private var showPhotoPicker = false
    var body: some View {
        VStack(alignment: .leading) {
            if !selectedPhoto.isEmpty {
                WebImage(url: URL(string: selectedPhoto))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
            }
            Button{
                showPhotoPicker.toggle()
            } label: {
                Text("Select a photo")
            }
            .sheet(isPresented: $showPhotoPicker, content: {
                NavigationStack {
                    FirebasePhotoPicker(selectedImage: $selectedPhoto)
                        .navigationBarItems (
                            leading:
                                Button(action: { showPhotoPicker.toggle() }) {
                                    Text("Cancel")
                                }
                        )
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
