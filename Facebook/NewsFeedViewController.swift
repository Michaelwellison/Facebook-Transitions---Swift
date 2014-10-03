//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var wedding1ImageView: UIImageView!
    @IBOutlet weak var wedding2ImageView: UIImageView!
    @IBOutlet weak var wedding3ImageView: UIImageView!
    @IBOutlet weak var wedding4ImageView: UIImageView!
    @IBOutlet weak var wedding5ImageView: UIImageView!
    
    // MARK: Variables
    var weddingImages : [UIImageView] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureWeddingImages()
        
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        
        activityIndicator.startAnimating()
        rootView.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
        
        delay(2.0, closure: {
            self.rootView.hidden = false
            self.activityIndicator.stopAnimating()
        })
    }
    
    func configureWeddingImages() {
        weddingImages += [wedding1ImageView, wedding2ImageView, wedding3ImageView, wedding4ImageView, wedding5ImageView]
        
        for item in weddingImages {
            var tapGesture = UITapGestureRecognizer(target: self, action: "onTapGesture:")
            item.addGestureRecognizer(tapGesture)
        }
    }
    
    func onTapGesture(tapgesture: UITapGestureRecognizer) {
        println("I just tapped that")
        performSegueWithIdentifier("photoDetailSegue", sender: self)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        
        destinationViewController.newImage = self.wedding1ImageView.image
    }
}
