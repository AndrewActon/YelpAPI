//
//  BusinessController.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/9/23.
//


import Foundation

class BusinessController {
    
    static let shared = BusinessController()
    
    //MARK: String Constants
    let apiKey = "3F-PXlkgkcIuUKqYhobbstwnmuB86pxMzgjj6nh2iHyPHPzMQMGJkEp3ECZxlV9QW4ff0TB4SFT3F-e5hX0dh6WJOEfCuCoFykoITslmt4O5OEvcigGeB96Tj4_pY3Yx"
    let baseURL = URL(string: "https://api.yelp.com/v3/")
    let businessEndpoint = "businesses"
    let searchEndpoint = "search"
    
    
    //MARK: Methods
    func fetchBusiness(searchTerm: String, completion: @escaping (Result<[Business], BusinessError>) -> Void ) {
        
        // 1 - URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let businessURL = baseURL.appending(path: businessEndpoint)
        
        let finalURL = businessURL.appending(path: searchEndpoint)
        
        print("Final URL: \(finalURL)")

        var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [
        URLQueryItem(name: "term", value: searchTerm),
        URLQueryItem(name: "location", value: "197 N Main St, Layton, UT 84041"),
        URLQueryItem(name: "limit", value: "10")
        ]
        
        print("Components URL: \(String(describing: components?.url))")
        
        guard let componentsURL = components?.url else { return completion(.failure(.invalidURL)) }
        print("Built URL \(componentsURL)")
        
        //MARK: HTTP Request
        var request =  URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        print("Request: \(request)")
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // 3 - Error Handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("BUSINESS STATUS CODE: \(response.statusCode)")
                }
            }
            
            // 4 - Check For Data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Decode Data

                do {
                    let yelpData = try JSONDecoder().decode(YelpData.self, from: data)
                    
                    return completion(.success(yelpData.businesses))
                    
                } catch let error {
                    print(error.localizedDescription)
                    return completion(.failure(.unableToDecode))
                }
        }.resume()
    }
}//End of Class
