//
//  ServiceClient.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation
import UIKit

internal protocol ServiceClientContractor {

    func performRequest<T: Decodable>(descriptor: RequestDescriptor, completion: @escaping (Result<T, ServiceError>) -> Void)
}

internal final class ServiceClient: NSObject, ServiceClientContractor, URLSessionTaskDelegate, URLSessionDelegate, URLSessionDataDelegate {
    
    private let urlSession: URLSession
    
    init(urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.ephemeral) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
    
    func performRequest<T: Decodable>(descriptor: RequestDescriptor, completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        let dataRequest = buildRequest(descriptor: descriptor)
        
        let dataTask = urlSession.dataTask(with: dataRequest) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                if !Reachability.isConnectedToNetwork(){
                    completion(.failure(ServiceError.internetNotAvailable))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      let data = data else {
                    completion(.failure(ServiceError.requestFailed(nil)))
                    return
                }
                
                if response.statusCode == 200 {
                    self?.on200ResponseWith(data: data, completion: completion)
                }  else {
                    self?.onErrorResponseCodeWith(data: data, completion: completion)
                }
            }
        }
        dataTask.resume()
    }
}

private extension ServiceClient {

    func buildRequest(descriptor: RequestDescriptor) -> URLRequest {

        let url = URL(string: descriptor.baseURL.absoluteString + descriptor.path)
       
        var headers = descriptor.headers ?? [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "*/*"

        let params = descriptor.params
        
        let request = self.request(url!,
                                   method: descriptor.method,
                                   parameters: params,
                                   headers: headers)
        return request
    }

    func request(_ url: URL,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = JsonEncoding(),
                 headers: HTTPHeaders? = nil) -> URLRequest {
        
        var originalRequest = URLRequest(url: url)
        originalRequest.allHTTPHeaderFields = headers
        originalRequest.httpMethod = method.rawValue

            return originalRequest

    }
}

private extension ServiceClient {

    func on200ResponseWith<T: Decodable>(data: Data, completion: @escaping (Result<T, ServiceError>) -> Void) {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedObject))
        }
        catch let error {
            print(error)
            completion(.failure(ServiceError.requestFailed(error.localizedDescription)))
        }
    }


    func onErrorResponseCodeWith<T: Decodable>(data: Data, completion: @escaping (Result<T, ServiceError>) -> Void) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let error = json as? Dictionary<String,AnyObject> {
                if let message = error["message"] as? String {
                    completion(.failure(ServiceError.requestFailed(message)))
                } else {
                    completion(.failure(ServiceError.requestFailed(nil)))
                }
            } else {
                completion(.failure(ServiceError.requestFailed(nil)))
            }
        } catch let error {
            completion(.failure(ServiceError.requestFailed(error.localizedDescription)))
        }
    }
}

