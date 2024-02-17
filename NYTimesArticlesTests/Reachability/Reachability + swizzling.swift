//
//  Reachability + swizzling.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import SystemConfiguration
import Foundation
@testable import NYTimesArticles

extension Reachability {
    @objc public class func swizzledIsConnectedToNetwork() -> Bool {
        return false // always return false
    }
    
    @objc public class func swizzledIsConnectedToNetworkOnInstance() -> Bool {
        let instance = Reachability()
        let selector = #selector(Reachability.swizzledIsConnectedToNetwork)
        guard let method = class_getInstanceMethod(Reachability.self, selector) else {
            return false
        }
        typealias Function = @convention(c) (AnyObject, Selector) -> Bool
        let function = unsafeBitCast(method_getImplementation(method), to: Function.self)
        return function(instance, selector)
    }
}

extension Reachability {
    static func swizzle(_ shouldRun: Bool) {
        let originalSelector = #selector(isConnectedToNetwork)
        let swizzledSelector = #selector(swizzledIsConnectedToNetworkOnInstance)

        guard let originalMethod = class_getClassMethod(self, originalSelector),
              let swizzledMethod = class_getClassMethod(self, swizzledSelector) else {
            return
        }

        if shouldRun {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        } else {
            method_exchangeImplementations(swizzledMethod, originalMethod)
        }
    }
}



