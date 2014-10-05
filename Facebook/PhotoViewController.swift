//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Michael Ellison on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var PhotoImageView: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView!
    var newImage : UIImage?
    var newImageView : UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePhotImageView()
        
        
    }
    
    func configurePhotImageView() {
        PhotoImageView.image = newImage
        PhotoImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        if newImageView!.tag == 0 {
            println("tag is \(newImageView!.tag)")
            PhotoImageView.frame = CGRect(x: scrollView.frame.origin.x, y: 70, width: 320, height: 400)
        } else {
            println("tag is \(newImageView!.tag)")
            self.PhotoImageView.frame = CGRect(x: 0, y: scrollView.center.y, width: 320, height: 213)
        }
        

        PhotoImageView.center = view.center
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDoneButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
