//
//  HomeScreenViewModel.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import Foundation
import Observation

@Observable
class HomeScreenViewModel {
    var api = APIService() // Instance of APIService for fetching photos.
    var results = [Result]() // Array to store fetched photo results.
    var page = 1 // Current page number for fetching photos.
    var isLoading = false // Indicates whether data is being loaded.
    var hasError = false // Indicates whether an error occurred during data fetching.
    var error: Error? // Stores the error object if an error occurs.
    
    // Initialize the view model and load data upon initialization.
    init() {
        loadData()
    }
    
    // Function to initially load data from the API.
    func loadData() {
        Task {
            do {
                self.results = try await api.fetchPhotos()
            } catch {
                hasError.toggle()
                self.error = error
            }
        }
    }
    
    // Function to load more data (pagination) from the API.
    func loadMore() {
        Task {
            do {
                isLoading = true // Set isLoading to true indicating data loading.
                page += 1 // Increment page number for fetching the next page of data.
                let response = try await api.fetchPhotos(page: page)
                self.results += response // Append fetched results to existing results.
            } catch {
                hasError.toggle()
                self.error = error
            }
            do{
                isLoading = false // Set isLoading to false indicating data loading finished.
            }
        }
    }
}
