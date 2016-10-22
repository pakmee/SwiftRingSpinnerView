//
//  ViewController.swift
//  SwiftRingSpinnerView
//
//  Created by Jonathan Siao on 22/10/2016.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinnerView: SwiftRingSpinnerView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinnerView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

