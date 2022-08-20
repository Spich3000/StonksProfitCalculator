//
//  NetworkingManager.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String?{
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL \(url)"
            case .unknown: return "Unknown error occured"
            }
        }
    }
    
    //  .eraseToAnyPublisher() help us to convert return to AnyPublisher<Data, Error>
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        // we dont need this line below, cause subscribe is on background for default
        // .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
        // try to get data 3 times
            .retry(3)
        // .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
