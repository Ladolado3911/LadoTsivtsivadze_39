//
//  NetworkManager.swift
//  LadoTsivtsivadze_39
//
//  Created by Ladolado3911 on 6/23/21.
//

import Foundation
import UIKit

/// დავალება 1

struct Object {
    var id: Int
    var name: String
    var surname: String
}

protocol NetworkManager: AnyObject {
    func fetchIds(completion: @escaping ([Int]) -> Void)
    func fetchObject(by id: Int, completion: @escaping (Object) -> Void)
}

extension NetworkManager {
    func fetchObjects(completion: @escaping ([Object]) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        fetchIds { [weak self] (ids) in
            guard let self = self else { return }
            var result: [Object] = []
            ids.forEach {
                self.fetchObject(by: $0, completion: { (object) in
                    result.append(object)
                    semaphore.signal()
                })
                semaphore.wait()
            }
            completion(result)
        }
    }
}
