//
//  ViewController.swift
//  HeroUse
//
//  Created by 黄家树 on 2017/12/9.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "DesViewController")
        present(vc, animated: true) {
            
        }
        
    }
    
}

