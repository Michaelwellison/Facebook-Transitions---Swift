//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Michael Ellison on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoViewImage: UIImageView!
    var newImage : UIImage?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoViewImage.image = newImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDoneButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
