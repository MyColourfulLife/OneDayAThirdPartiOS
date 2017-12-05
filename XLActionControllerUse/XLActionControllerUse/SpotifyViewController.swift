//
//  SpotifyViewController.swift
//  XLActionControllerUse
//
//  Created by 黄家树 on 2017/12/5.
//  Copyright © 2017年 黄家树. All rights reserved.
//

import UIKit
import XLActionController

class SpotifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        let actionController = SpotifyActionController()
        actionController.headerData = SpotifyHeaderData(title: "The Fast And The Furious Soundtrack Collection", subtitle: "Various Artists", image: UIImage(named: "sp-header-icon")!)
        actionController.addAction(Action(ActionData(title: "Save Full Album", image: UIImage(named: "sp-add-icon")!), style: .default, handler: { action in }))
        actionController.addAction(Action(ActionData(title: "Remove", image: UIImage(named: "sp-remove-icon")!), style: .default, handler: { action in }))
        actionController.addAction(Action(ActionData(title: "Share", image: UIImage(named: "sp-share-icon")!), style: .default, handler: { action in }))
        actionController.addAction(Action(ActionData(title: "Go to Album", image: UIImage(named: "sp-view-album-icon")!), style: .default, handler: { action in }))
        actionController.addAction(Action(ActionData(title: "Start radio", image: UIImage(named: "sp-radio-icon")!), style: .default, handler: { action in }))
        
        
        present(actionController, animated: true, completion: nil)
    }

}
