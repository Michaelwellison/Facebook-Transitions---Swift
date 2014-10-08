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
        
        wedding1ImageView.tag = 0
        wedding2ImageView.tag = 1
        wedding3ImageView.tag = 2
        wedding4ImageView.tag = 3
        wedding5ImageView.tag = 4
        
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
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var smallImageView : UIImageView?
        
        if (isPresenting) {
            
            containerView.addSubview(toViewController!.view)
            toViewController!.view.hidden = true
            
            var imageView = UIImageView(frame: CGRect(x: self.selectedImageView!.frame.origin.x, y: self.selectedImageView!.frame.origin.y + self.navBarImage.frame.height + self.composeImageView.frame.height, width: self.selectedImageView!.frame.width, height: self.selectedImageView!.frame.height))
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.image = self.selectedImageView!.image
            containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            containerView.addSubview(imageView)
            imageView.clipsToBounds = true
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                if self.selectedImageView!.tag == 0 {
                    imageView.frame = CGRect(x: 0, y: 45, width: 320, height: 480)
                } else {
                    imageView.frame = CGRect(x: 0, y: containerView.center.y, width: 320, height: 213)
                    imageView.center = containerView.center

                }
                    containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                
                }, completion: { (finished: Bool) -> Void in

                    imageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    toViewController!.view.hidden = false
                    containerView.backgroundColor = UIColor.clearColor()
            })
            
        } else {

            fromViewController!.view.hidden = true
            containerView.addSubview(fromViewController!.view)
            containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            var imageView = UIImageView(image: self.selectedImageView!.image)
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            let vc = fromViewController as PhotoViewController
            
            imageView.frame = selectedImageView!.frame
            imageView.frame.origin.y -= vc.scrollView!.contentOffset.y - 44
            
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                fromViewController!.view.alpha = 0
                containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                imageView.contentMode = UIViewContentMode.ScaleAspectFill
                switch vc.scrollView.contentOffset.x {
                case 0:
                    imageView.frame = CGRect(x: 4, y: 83 + 110, width: 154, height: 154)
                case 320:
                    imageView.frame = CGRect(x: 4, y: 241 + 110, width: 154, height: 154)
                case 640:
                    imageView.frame = CGRect(x: 161, y: 81 + 110, width: 156, height: 105)
                case 960:
                    imageView.frame = CGRect(x: 161, y: 188 + 110, width: 156, height: 105)
                case 1280:
                    imageView.frame = CGRect(x: 161, y: 293 + 110, width: 156, height: 105)
                default:
                    println("nothing happens")
                
                }
//                imageView.frame = self.selectedImageView!.frame
//                println("newImageView tag is \(vc.newImageView!.tag)")
//                println("selectedImageView is \(self.selectedImageView!.frame)")
//                imageView.frame.origin.y += self.navBarImage.frame.height + self.composeImageView.frame.height
                
                }, completion: { (finished: Bool) -> Void in
                    
                    transitionContext.completeTransition(false)
                    fromViewController?.view.removeFromSuperview()
            })
        }
    }
    
    // MARK: Actions
    

    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
        destinationViewController.newImage = self.selectedImageView!.image
        destinationViewController.newImageView = self.selectedImageView!
        destinationViewController.newImageViews = self.weddingImages
    }
}
