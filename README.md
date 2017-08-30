## RefreshableViewController

RefreshableViewController is simple view controller with refreshable state management based on PromiseKit.

Example usage:

```swift
import UIKit
import PromiseKit
import RefreshableViewController

struct APIClient {
    
    static func getItem(itemID: Int) -> Promise<Item> {
        return Promise { fulfill, reject in
            // Make HTTP requests, etc...
            let item = Item(name: "Item Name")
            fulfill(item)
        }
    }
    
}

struct Item {

    let name: String
    
}

class ItemViewController: RefreshableViewController<Item> {
    
    convenience init(itemID: Int) {
        self.init(request: APIClient.getItem(itemID: itemID))
    }
    
    override func refreshState() {
        super.refreshState()
        
        switch state {
        case .ready:
            print("View controller is ready")
        case .loading:
            print("View controller is loading")
        case .success(let item):
            print("View controller loaded item with name: \(item.name)")
        case .failure(let error):
            print("View controller failed to load item with error: \(error)")
        }
    }

}
```