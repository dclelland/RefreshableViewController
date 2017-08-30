//
//  RefreshableViewController.swift
//  TREX
//
//  Created by Daniel Clelland on 30/08/17.
//  Copyright © 2017 Daniel Clelland. All rights reserved.
//

import UIKit
import PromiseKit

// MARK: Refreshable view controller

public class RefreshableViewController<T>: UIViewController {
    
    // MARK: Initializers
    
    public convenience init(request: @autoclosure @escaping (Void) -> Promise<T>) {
        self.init()
        self.request = request
    }
    
    public convenience init(response: T) {
        self.init()
        self.state = .success(response: response)
    }
    
    // MARK: Public state
    
    public final var request: ((Void) -> Promise<T>)? {
        didSet {
            refresh()
        }
    }
    
    public final var state: RefreshableState<T> = .ready {
        didSet {
            refreshState()
        }
    }
    
    // MARK: Overrides
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if request != nil {
            refresh()
        } else {
            refreshState()
        }
    }
    
    // MARK: Refresh
    
    public final func refresh() {
        guard let request = request else {
            return
        }
        
        self.state = .loading
        
        request().then { response in
            self.state = .success(response: response)
        }.catch { error in
            self.state = .failure(error: error)
        }
    }
    
    public func refreshState() {
        // This should be overridden in subclasses
    }
    
}
