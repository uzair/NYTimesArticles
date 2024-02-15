//
//  ServiceManager.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal protocol ServiceManagerContractor {

    func performRequest<T: Decodable>(desriptor: RequestDescriptor, completion: @escaping (Result<T, ServiceError>) -> Void)
}

internal final class ServiceManager: ServiceManagerContractor {

    private var serviceClient: ServiceClientContractor

    init(serviceClient: ServiceClientContractor = ServiceClient() ) {
        self.serviceClient = serviceClient
       
    }
    
    func performRequest<T: Decodable>(desriptor: RequestDescriptor, completion: @escaping (Result<T, ServiceError>) -> Void) {
            serviceClient.performRequest(descriptor: desriptor, completion: completion)
    }
}

