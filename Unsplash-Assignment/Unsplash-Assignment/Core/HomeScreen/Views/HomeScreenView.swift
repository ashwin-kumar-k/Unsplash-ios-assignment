//
//  ContentView.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import SwiftUI

struct HomeScreenView: View {
    @State var vm = HomeScreenViewModel() // ViewModel for managing data and business logic.
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    // Display photos in a grid layout
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                        ForEach(vm.results, id: \.id) { result in
                            // Display each photo asynchronously using AsyncCachedImage
                            AsyncCachedImage(url: URL(string: result.urls.thumb), content: { Image in
                                Image
                                    .resizable()
                                    .scaledToFill()
                            }, placeholder: {
                                ProgressView()
                            })
                            .onAppear{
                                // Load more data when the last photo appears
                                if result.id == vm.results.last?.id{
                                    vm.loadMore()
                                }
                            }
                        }
                        .frame(width: 110, height: 110)
                        .background(.gray.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 8))
                        
                        
                    }
                    .padding(.horizontal)
                    // Display a loading indicator if data is loading
                    if vm.isLoading{
                        ProgressView()
                    }
                }
            }
            // Overlay content for handling errors and displaying alerts
            .overlay{
                if vm.error != nil && vm.results.isEmpty {
                    ContentUnavailableView(label: {
                        Label("Oops, something went wrong.", systemImage: "xmark.circle")
                    }, actions:  {
                        Button("Try again"){
                            vm.loadData()
                        }
                    })
                    
                }
            }
            .alert(isPresented: $vm.hasError, content: {
                Alert(title: Text("Error!"), message: Text(vm.error?.localizedDescription ?? ""))
            })
            .refreshable {
                // Reset page and results when refreshing
                vm.page = 1
                vm.results.removeAll()
                vm.loadData()
                
            }
            .navigationTitle("Unsplash") // Set navigation title
            
        }
    }
}

#Preview {
    HomeScreenView() // Preview the HomeScreenView
}


