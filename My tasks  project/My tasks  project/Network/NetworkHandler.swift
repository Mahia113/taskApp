//
//  NetworkHandler.swift
//  My tasks  project
//
//  Created by Anzen on 13/04/22.
//
import Foundation

public struct NetworkHandler {
    
    /**
     Perform API request with given URL.
     - Parameters:
        - url: URL for API request.
     - Returns: HTTP data response.
     */
    func performAPIRequestByURL(url: String, completion: @escaping (Result<Data, NetworkHandlerError>) -> Void) {
        if let url = URL(string: url) {
            print(url)
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url) {
                switch $0 {
                case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse(error: decodeError(data: data) ?? ErrorMessage(error: "invalidResponse"))))
                    return
                }
                completion(.success(data))
                case .failure( _):
                completion(.failure(.apiError))
                }
            }.resume()
        } else {
            completion(.failure(.invalidURL))
        }
    }
    
    /**
     Decode JSON response for codable struct model.
     - Parameters:
        - data: HTTP data response.
     - Returns: Model struct of associated variable type.
     */
    func decodeJSONData<T: Codable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
    /**
     Decode JSON error response.
     - Parameters:
        - data: HTTP data response.
     - Returns: Error message struct.
     */
    func decodeError(data: Data) -> ErrorMessage? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ErrorMessage.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}

/**
 Extension to implement <Result> type in URLSession.
 */
extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
