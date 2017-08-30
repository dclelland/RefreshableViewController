//
//  RefreshableState.swift
//  RefreshableViewController
//
//  Created by Daniel Clelland on 30/08/17.
//  Copyright © 2017 Daniel Clelland. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: Refreshable state

public enum RefreshableState<T> {
    
    case ready
    
    case loading
    
    case success(T)
    
    case failure(Error)
    
    // MARK: Mutable properties
    
    public var value: T? {
        set {
            guard let value = newValue else {
                if case .success = self {
                    self = .ready
                }
                
                return
            }
            
            self = .success(value)
        }
        get {
            guard case .success(let response) = self else {
                return nil
            }
            
            return response
        }
    }
    
    public var error: Error? {
        set {
            guard let error = newValue else {
                if case .failure = self {
                    self = .ready
                }
                
                return
            }
            
            self = .failure(error)
        }
        get {
            guard case .failure(let error) = self else {
                return nil
            }
            
            return error
        }
    }
    
}
