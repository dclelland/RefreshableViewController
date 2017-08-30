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
    
    case success(response: T)
    
    case failure(error: Error)
    
}
