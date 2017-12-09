//
//  DesViewController.swift
//  HeroUse
//
//  Created by 黄家树 on 2017/12/9.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit
import Hero

class DesViewController: UIViewController {

    @IBOutlet weak var hello: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hello.heroModifiers = [.translate(x:0, y:100), .scale(0.5)]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true) {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
