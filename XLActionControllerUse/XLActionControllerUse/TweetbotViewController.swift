//
//  TweetbotViewController.swift
//  XLActionControllerUse
//
//  Created by 黄家树 on 2017/12/5.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit
import XLActionController

class TweetbotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backtaped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapGestureDidRecognize(_ sender: UITapGestureRecognizer) {
        let actionController = TweetbotActionController()
        
        actionController.addAction(Action("View Details", style: .default, handler: { action in
        }))
        actionController.addAction(Action("View Retweets", style: .default, handler: { action in
        }))
        actionController.addAction(Action("View in Favstar", style: .default, handler: { action in
        }))
        actionController.addAction(Action("Translate", style: .default, executeImmediatelyOnTouch: true, handler: { action in
        }))
        actionController.addSection(Section())
        actionController.addAction(Action("Cancel", style: .cancel, handler:nil))
        
        present(actionController, animated: true, completion: nil)
    }

}
