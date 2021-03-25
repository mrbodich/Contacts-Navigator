//
//  RandomImageFetchingOperation.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

class RandomImageFetchingOperation: ControlledOperation {
    let imageSize = 5000
    let urlString: String
    let completionHandler: (_ image: UIImage) -> ()
    
    init(urlString: String, completionHandler: @escaping (_ image: UIImage) -> ()) {
        self.urlString = urlString
        self.completionHandler = completionHandler
    }
    
    override func main() {
        guard let url = URL(string: "\(urlString)\(imageSize)") else {
            stopOperation()
            return
        }
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.stopOperation() }
            if let error = error {
                print("‼️ Fetching image failed with error: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            self?.completionHandler(image)
        }
        urlSession.resume()
    }
}

class ControlledOperation: Operation {
    
    private var _finished = false
    private var _executing = false
    
    override var isExecuting: Bool {
        get { return !_executing }
        set {
            willChangeValue(forKey: "isExecuting") // This must match the overriden variable
            _executing = newValue
            didChangeValue(forKey: "isExecuting") // This must match the overriden variable
        }
    }
    
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished") // This must match the overriden variable
            _finished = newValue
            didChangeValue(forKey: "isFinished") // This must match the overriden variable
        }
    }
    
    func stopOperation() {
        isFinished = true
        isExecuting = false
    }
    
    func startOperation() {
        isFinished = false
        isExecuting = true
    }
}
