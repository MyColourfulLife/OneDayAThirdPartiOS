//
//  TwiiterViewController.swift
//  XLActionControllerUse
//
//  Created by 黄家树 on 2017/12/5.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit
import XLActionController


class TwiiterViewController: UIViewController {

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

    @IBAction func tapGestureDidRecognize(_ sender: UITapGestureRecognizer) {
        
        let actionController = TwitterActionController()
        actionController.addAction(Action(ActionData(title: "Xmartlabs", subtitle: "@xmartlabs", image: UIImage(named: "tw-xmartlabs")!), style: .default, handler: { action in
        }))
        actionController.addAction(Action(ActionData(title: "Miguel", subtitle: "@remer88", image: UIImage(named: "tw-remer")!), style: .default, handler: { action in
        }))
        actionController.headerData = "Accounts"
        present(actionController, animated: true, completion: nil)
        
    }

}
