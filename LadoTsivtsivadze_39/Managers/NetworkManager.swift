//
//  NetworkManager.swift
//  LadoTsivtsivadze_39
//
//  Created by Ladolado3911 on 6/23/21.
//

import Foundation
import UIKit

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
    func fetchObjects(completion: @escaping ([Object?]) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        fetchIds { [weak self] (ids) in
            guard let self = self else { return }
            var testObject: Object?
            var result: [Object?] = []
            ids.forEach {
                self.fetchObject(by: $0, completion: { (object) in
                    testObject = object
                })
                result.append(testObject)
                semaphore.wait()
            }
            semaphore.signal()
            completion(result)
        }
    }
}
