//
//  EnvironmentManager.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

public enum Environment: Int {
    case sandbox
    case production
}

protocol EnvironmentManagerContractor {
    func getEnvironment() -> Environment
    func enableSandboxEnvironment()
    func enableProductionEnvironment()
}

final class EnvironmentManager: EnvironmentManagerContractor {

    private var environment: Environment = .sandbox

    static let sharedInstance: EnvironmentManager = EnvironmentManager()

    init() {
    }

    func getEnvironment() -> Environment {
        environment
    }

    func enableSandboxEnvironment() {
        self.environment = .sandbox
    }
    
    func enableProductionEnvironment() {
        self.environment = .production
    }
}
