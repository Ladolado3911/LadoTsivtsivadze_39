//
//  ViewController.swift
//  LadoTsivtsivadze_39
//
//  Created by Ladolado3911 on 6/23/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let queue1 = DispatchQueue(label: "thread 1", attributes: .concurrent)
        let queue2 = DispatchQueue(label: "thread2", attributes: .concurrent)
        
        let semaphore = DispatchSemaphore(value: 0)
        
/// აქ ვივარჯიშე
        
//        queue1.async {
//            //guard let self = self else { return }
//            print("sleeping in queue1...")
//            var test = ""
//            Thread.sleep(forTimeInterval: 3)
//            queue2.async {
//                print("sleeping in queue2...")
//                Thread.sleep(forTimeInterval: 3)
//                test = "sucess"
//                print("queue2 done sleeping")
//                semaphore.signal()
//            }
//            print("semaphore wait activated")
//            semaphore.wait()
//            print("queue1 done sleeping")
//            print("test is \(test)")
//        }
        
/// აქ გავტესტე დავალება 1 ის სისწორე
        
        queue1.async {
            //print("1")
            //print("2")
            
            var result: [Int] = []
            
            for a in 0..<5 {
                queue2.async {
                    //print("repeat")
                    result.append(a)
                    semaphore.signal()
                }
                semaphore.wait()
            }

            //print("3")
            //print("4")
            //print("5")
            
            //print(result)
        }
    }
    
/// დავალება 2
    
    @IBAction func onPrint(_ sender: Any) {
        printNumbers()
    }
    
    func printNumbers() {
        print("Fetch 1")
        
        DispatchQueue.main.async {
            print("Fetch 2")
            DispatchQueue.main.async {
               print("Fetch 3")
            }
            DispatchQueue.main.async {
                print("Fetch 4")
            }
            DispatchQueue.global().sync {
                print("Fetch 5")
            }
        }
        
        DispatchQueue.main.async {
            print("Fetch 8")
                DispatchQueue.main.async {
                    print("Fetch 9")
                        DispatchQueue.global().sync {
                            print("Fetch 10")
                        }
                }
        }
        
        print("Fetch 6")
        
        DispatchQueue.main.async {
            print("Fetch 7")
                DispatchQueue.global().sync {
                    print("Fetch 11")
                        DispatchQueue.global().sync {
                            print("Fetch 12")
                                DispatchQueue.main.async {
                                    print("Fetch 13")
                                }
                        }
                }
        }
    }
}

