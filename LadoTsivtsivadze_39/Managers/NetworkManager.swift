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
    func fetchObject(completion: @escaping (Object) -> Void)
}

extension NetworkManager {
    func fetchObjects(completion: @escaping ([Object]) -> Void) {
        fetchIds { [weak self] (ids) in
            guard let self = self else { return }
            var testObject: Object = Object(id: 0, name: "", surname: "")
            var result: [Object] = []
            ids.forEach {
                while testObject.id != $0 {
                    self.fetchObject { (object) in
                        testObject = object
                    }
                }
                result.append(testObject)
            }
            completion(result)
        }
    }
}
