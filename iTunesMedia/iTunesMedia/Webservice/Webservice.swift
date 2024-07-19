//
//  Webservice.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import Foundation
import Combine

struct Webservice{
    static let shared = Webservice()
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "https://itunes.apple.com/search?term="
    
    func getMethod<T:Decodable>(path: String, isMock: Bool, type: T.Type , failureScenerio: Bool ,
                                mockPath: String) -> AnyPublisher<T, NetworkError>{
        var urlData: URL?
        
        if failureScenerio {
            return Fail(error: NetworkError.unAuthuroziedError)
                .eraseToAnyPublisher()
        }
        if isMock{
            guard let url = Bundle.main.url(forResource: mockPath, withExtension: "json")
            else{
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            urlData = url
            
            do {
                let data = try Data(contentsOf: url)
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        NetworkError.decodingFailed(error)
                    }
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            
        }else{
            guard let url = URL(string: baseURL + path)
            else{
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            urlData = url
        }
        return URLSession.shared.dataTaskPublisher(for: urlData!)
        //            .receive(on: RunLoop.main)
            .tryMap { data, response in
                print(data)
                guard let httpResponse = response as? HTTPURLResponse ,
                      httpResponse.statusCode == 200
                else{
                    throw NetworkError.invalidResponse
                }
                
                return data
            }
            .decode(type: T.self, decoder:JSONDecoder())
            .mapError { error in
                NetworkError.decodingFailed(error)
            }
            .eraseToAnyPublisher()
    }
    
    
    
    
    
    func postMethod<T:Decodable>(path: String, isMock: Bool, type: T.Type ,payLoad: Encodable, failureScenerio: Bool ,
                                 mockPath: String) -> AnyPublisher<T, NetworkError>{
        var urlData: URL?
        
        //        This Condition helps to test the negative Network failure scenerio
        if failureScenerio {
            return Fail(error: NetworkError.unAuthuroziedError)
                .eraseToAnyPublisher()
        }
        //        Is isMock is true this block will be execute and getting a data from mock files
        if isMock{
            guard let url = Bundle.main.url(forResource: mockPath, withExtension: "json")
            else{
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            urlData = url
            
            do {
                let data = try Data(contentsOf: url)
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        NetworkError.decodingFailed(error)
                    }
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            
        }else{
            guard let url = URL(string: path)
            else{
                return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
            }
            urlData = url
        }
        
        guard let postData = try? JSONEncoder().encode(payLoad) else {
            // Handle encoding failure
            fatalError("Failed to encode post object")
        }
        
        //            Add method type
        var request = URLRequest(url: urlData!) // Change this line
        request.httpMethod = "POST" // Change this line
        request.httpBody = postData
        
        return URLSession.shared.dataTaskPublisher(for: request)
        //            .receive(on: RunLoop.main)
            .tryMap { data, response in
                print(data)
                guard let httpResponse = response as? HTTPURLResponse ,
                      httpResponse.statusCode == 200
                else{
                    throw NetworkError.invalidResponse
                }
                
                return data
            }
            .decode(type: T.self, decoder:JSONDecoder())
            .mapError { error in
                NetworkError.decodingFailed(error)
            }
            .eraseToAnyPublisher()
    }
    
}
