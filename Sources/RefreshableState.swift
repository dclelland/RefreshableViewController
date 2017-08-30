//
//  RefreshableState.swift
//  TREX
//
//  Created by Daniel Clelland on 30/08/17.
//  Copyright © 2017 Daniel Clelland. All rights reserved.
//

import Foundation

// MARK: Refreshable state

public enum RefreshableState<T> {
    
    case ready
    
    case loading
    
    case success(T)
    
    case failure(Error)
    
    // MARK: Mutable properties
    
    var value: T? {
        set {
            guard let value = newValue else {
                // set to ready or failure
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
    
    var error: Error? {
        set {
            guard let error = newValue else {
                // set to ready or failure
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
