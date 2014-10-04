//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
   
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
    
    @IBOutlet weak var navBarImage: UIImageView!
    
    @IBOutlet weak var composeImageView: UIImageView!
    
    // MARK: Variables
    var weddingImages : [UIImageView] = []
    var selectedImageView : UIImageView?
    var isPresenting : Bool = true
    
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
    
    // MARK: Configuration
    
    func configureWeddingImages() {
        weddingImages += [wedding1ImageView, wedding2ImageView, wedding3ImageView, wedding4ImageView, wedding5ImageView]
        
        for item in weddingImages {
            var tapGesture = UITapGestureRecognizer(target: self, action: "onTapGesture:")
            item.addGestureRecognizer(tapGesture)
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onTapGesture(tapGesture: UITapGestureRecognizer) {
        
        selectedImageView = tapGesture.view as? UIImageView
        self.performSegueWithIdentifier("photoDetailSegue", sender: self)
    }
    
    // MARK: Transition Delegate Methods
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    // MARK: Animated Transitioning Functions
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        if (isPresenting) {
            containerView.addSubview(toViewController!.view)
            
            var imageView = UIImageView(frame: CGRect(x: self.selectedImageView!.frame.origin.x, y: self.selectedImageView!.frame.origin.y + self.navBarImage.frame.height + self.composeImageView.frame.height, width: self.selectedImageView!.frame.width, height: self.selectedImageView!.frame.height))
            println("x is \(imageView.frame.origin.x) and y is \(imageView.frame.origin.y)")
            imageView.image = self.selectedImageView!.image
            containerView.addSubview(imageView)
            toViewController!.view.alpha = 0
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                imageView.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
                toViewController!.view.alpha = 1
    
                }, completion: { (finished: Bool) -> Void in
                imageView.removeFromSuperview()
                transitionContext.completeTransition(true)
                    
            })
        } else {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                fromViewController!.view.alpha = 0
                }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController?.view.removeFromSuperview()
            })
        }
    }

    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
        destinationViewController.newImage = self.selectedImageView!.image
    }
}
