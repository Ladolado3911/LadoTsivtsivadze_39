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
            var iteration = 0
            ids.forEach {
                iteration += 1
                self.fetchObject(by: $0, completion: { (object) in
                    testObject = object
                })
                result.append(testObject)
                if iteration == ids.count {
                    semaphore.signal()
                }
            }
            semaphore.wait()
            completion(result)
        }
    }
}
