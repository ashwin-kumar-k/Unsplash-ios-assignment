//
//  APIService.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import Foundation

class APIService {
    let session = URLSession.shared // Initialize URLSession for network requests.
    let jsonDecoder = JSONDecoder() // Initialize JSONDecoder for decoding JSON data.

#error("Please add your API Access key below and then delete this line.")
    let accessKey = "YOUR_API_ACCESS_KEY" // API Access Key for Unsplash API.
    
    // Function to fetch photos from the Unsplash API asynchronously.
    // Parameters:
    // - page: The page number of the results to fetch (default is 1).
    // Throws: AppError if there are issues with URL, server, or data.
    // Returns: An array of Result objects representing the fetched photos.
    func fetchPhotos(page: Int = 1) async throws -> [Result] {
        // Construct the URL for fetching photos.
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)&per_page=30") else {
            throw AppError.invalidURL
        }
        
        // Create a URLRequest with the constructed URL.
        var request = URLRequest(url: url)
        
        // Set authorization header with the access key for Unsplash API.
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
        // Perform the network request asynchronously and get the response data.
        let (data, response) = try await session.data(for: request)
        
        // Check if the response status code indicates success (200 OK).
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw AppError.serverError
        }
        
        // Decode the JSON data into an array of Result objects.
        guard let results = try? jsonDecoder.decode([Result].self, from: data) else {
            throw AppError.invalidData
        }
        
        // Return the fetched results.
        return results
    }
}
