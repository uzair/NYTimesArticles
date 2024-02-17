//
//  Coordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

protocol Coordinator {
    var resolver: CoordinatorResolverContractor? { get set }
    func start()
}


