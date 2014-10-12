//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Michael Ellison on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var PhotoImageView: UIImageView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK: Variables
    var newImageView : UIImageView?
    var newImageViews : [UIImageView] = []
    var newSelectedImageView = UIImageView()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configurePhotoImageView()
        view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Configuration
    
    func configurePhotoImageView() {
        
        var i = 0
        while i < 5 {
            var photoImageView = UIImageView()
            photoImageView.contentMode = UIViewContentMode.ScaleAspectFill
            photoImageView.userInteractionEnabled = true
            photoImageView.tag = i
            scrollView.addSubview(photoImageView)
            newImageViews += [photoImageView]
            
            switch photoImageView.tag {
            case 0:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x, y: 70, width: 320, height: 480)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding1")
                
            case 1:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x + 320, y: scrollView.center.y, width: 320, height: 213)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding2")
                
                
            case 2:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x + 640, y: scrollView.center.y, width: 320, height: 213)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding3")
                
            case 3:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x + 960, y: scrollView.center.y, width: 320, height: 213)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding4")
                
            case 4:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x + 1280, y: scrollView.center.y, width: 320, height: 213)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding5")
                
            default:
                photoImageView.frame = CGRect(x: scrollView.frame.origin.x, y: scrollView.center.y, width: 320, height: 213)
                photoImageView.center.y = scrollView.center.y
                photoImageView.image = UIImage(named: "wedding1")
            }
            
            i++
        }
    }
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: 1600, height: 585)
        scrollView.contentOffset.y = 44
        scrollView.contentInset = UIEdgeInsets(top: -46, left: 0, bottom: -44, right: 0)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        scrollView.pagingEnabled = true
        scrollView.directionalLockEnabled = true
        
        switch newImageView!.tag {
        case 0:
            scrollView.contentOffset.x = 0
        case 1:
            scrollView.contentOffset.x = 320
        case 2:
            scrollView.contentOffset.x = 640
        case 3:
            scrollView.contentOffset.x = 960
        case 4:
            scrollView.contentOffset.x = 1280
        default:
            scrollView.contentOffset.x = 0
        }
        
    }
    
    // MARK: Scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var velocity = scrollView.panGestureRecognizer.velocityInView(view)
        
        if scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            if velocity.y > 0 {
                buttonContainerView.alpha += -0.0355
                
                
                println(newSelectedImageView.frame)
            }
        }
    
        if scrollView.contentOffset.y <= -44 {
            dismissViewControllerAnimated(true, completion: nil)
            
            switch scrollView.contentOffset.x {
            case 0:
                newSelectedImageView = newImageViews[0]
            case 320:
                newSelectedImageView = newImageViews[1]
            case 640:
                newSelectedImageView = newImageViews[2]
            case 960:
                newSelectedImageView = newImageViews[4]
            default:
                newSelectedImageView = newImageViews[4]
                
                println(newSelectedImageView.frame)
            }
            
            
        }
    
        if scrollView.dragging == false {
            UIView.animateWithDuration(0.6, animations: { () -> Void in
            self.buttonContainerView.alpha = 1
            })}
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return PhotoImageView
        
    }
    
    // MARK: Actions

    @IBAction func onDoneButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

