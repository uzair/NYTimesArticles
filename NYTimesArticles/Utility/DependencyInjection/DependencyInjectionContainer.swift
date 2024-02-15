//
//  DependencyInjectionContainer.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

protocol DependencyInjectionContainerContractor {
    func register<Service>(type: Service.Type, service: Any)
    func resolve<Service>(type: Service.Type) -> Service?
    func mandatoryResolve<Service>(type: Service.Type) -> Service
}


final class DependencyInjectionContainer: DependencyInjectionContainerContractor {

    static let shared: DependencyInjectionContainer = {
        let container = DependencyInjectionContainer()
        container.registerDependencies()
        return container
    }()
    
    private var services: [String: Any] = [:]

    private init() {
        // Made init private so as to not be initialized as a non singelton instance.
    }
    
    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"] as? Service
    }

    func mandatoryResolve<Service>(type: Service.Type) -> Service {
        guard let safeService = services["\(type)"] as? Service else {
            fatalError("Service with type: \(type) could not be resolved")
        }
        return safeService
    }
}


internal extension DependencyInjectionContainer {

    func registerDependencies() {
        register(type: EnvironmentManagerContractor.self, service: EnvironmentManager.sharedInstance)
        
    }
}
