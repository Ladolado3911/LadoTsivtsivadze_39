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
//        print("1")
//        DispatchQueue.main.async {
//            print("2")
//        }
//        print("3")
//        DispatchQueue.main.async {
//            print("4")
//        }
//        print("5")
//        DispatchQueue.main.async {
//            print("6")
//        }
//        print("7")
    }
    
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

