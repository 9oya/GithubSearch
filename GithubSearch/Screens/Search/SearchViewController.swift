//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/05.
//

import UIKit

class SearchViewController: UIViewController {
    
    let sequence: [String] = ["A", "B", "C", "D", "E", "F", "G"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension SearchViewController {
    
    private func gcdSyncAsync() {
        
        var currChar: String?
        sequence.forEach { char in
            let queue = DispatchQueue(label: "background.worker",
                                      attributes: .concurrent)
            queue.async {
                // Call slow non-UI methods here
                currChar = char
                
                DispatchQueue.main.async {
                    // Update the UI here
                    print(currChar!)
                }
            }
        }
    }
    
    func gcdB() {
        let queue = DispatchQueue.global(qos: .userInitiated)
    }
    
}
