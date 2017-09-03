//
//  RefreshableTableViewController.swift
//  RefreshableViewController
//
//  Created by Daniel Clelland on 30/08/17.
//  Copyright © 2017 Daniel Clelland. All rights reserved.
//

import UIKit
import PromiseKit

// MARK: Refreshable table view controller

open class RefreshableTableViewController<Value>: UITableViewController, Refreshable {
    
    // MARK: Initializers
    
    public convenience init(style: UITableViewStyle, request: @autoclosure @escaping (Void) -> Promise<Value>) {
        self.init(style: style)
        self.request = request
    }
    
    public convenience init(style: UITableViewStyle, value: Value) {
        self.init(style: style)
        self.state = .success(value)
    }
    
    // MARK: Public state
    
    public final var request: ((Void) -> Promise<Value>)? {
        didSet {
            refresh()
        }
    }
    
    public final var state: RefreshableState<Value> = .ready {
        didSet {
            refreshState()
        }
    }
    
    // MARK: Overrides
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if request != nil {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refresh()
        } else {
            refreshState()
        }
    }
    
    // MARK: Refreshable
    
    public final func refresh() {
        guard let request = request else {
            refreshState()
            return
        }
        
        self.state = .loading
        
        request().then { value in
            self.state = .success(value)
        }.always {
            self.refreshControl?.endRefreshing()
        }.catch { error in
            self.state = .failure(error)
        }
    }
    
    open func refreshState() {
        // This should be overridden in subclasses
    }
    
}
