//
//  ViewController.swift
//  Sample
//
//  Created by Elias Abel on 2017/1/3.
//  Copyright © 2017 Meniny. All rights reserved.
//

import UIKit
import UIMessageBar

let message = """
Here’s to the crazy ones. The misfits. The rebels.
The troublemakers. The round pegs in the square holes – the ones who see things differently.
They’re not fond of rules and they have no respect for the status quo. You can praise them, disagree with them, quote them, disbelieve them, glorify or vilify them.
About the only thing that you can’t do is ignore them.
Because they change things.
    Take care,
    John Appleseed
"""

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var hasIcon = false
    
    @IBAction func show(_ sender: UIButton) {
        
        UIMessageBar.show(.cardView,
                          at: .bottom,
                          title: "Dear Kate",
                          message: message,
                          icon: hasIcon ? UIMessageBar.Icon.info.image : nil,
                          button: "Got it",
                          duration: 0,
                          action: nil)
        hasIcon = !hasIcon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

