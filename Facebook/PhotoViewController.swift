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
    var newImage : UIImage?
    var newImageView : UIImageView?
    var newImageViews : [UIImageView]?
    var NewsFeedViewControllerScreenShot : UIView?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("view loaded")
        configureScrollView()
        
        view.backgroundColor = UIColor.clearColor()
//        scrollView.backgroundColor = UIColor.clearColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        println("view did appear")
        configurePhotoImageView()
    }
    
    // MARK: Configuration
    
    func configurePhotoImageView() {
//        PhotoImageView.image = newImage
  //      PhotoImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
//        if newImageView!.tag == 0 {
//            println("tag is \(newImageView!.tag)")
//            PhotoImageView.frame = CGRect(x: scrollView.frame.origin.x, y: 70, width: 320, height: 400)
//        } else {
//            println("tag is \(newImageView!.tag)")
//            self.PhotoImageView.frame = CGRect(x: 0, y: scrollView.center.y, width: 320, height: 213)
//        }

        
        for item in newImageViews! {
            item.contentMode = UIViewContentMode.ScaleAspectFill
            scrollView.addSubview(item)
            
            switch item.tag {
            case 0:
                item.frame = CGRect(x: scrollView.frame.origin.x, y: 70, width: 320, height: 480)
                item.center.y = scrollView.center.y
                println(scrollView.frame)
                
            case 1:
                item.frame = CGRect(x: scrollView.frame.origin.x + 320, y: scrollView.center.y, width: 320, height: 213)
                item.center.y = scrollView.center.y
                
                
            case 2:
                item.frame = CGRect(x: scrollView.frame.origin.x + 640, y: scrollView.center.y, width: 320, height: 213)
                item.center.y = scrollView.center.y
                
            case 3:
                item.frame = CGRect(x: scrollView.frame.origin.x + 960, y: scrollView.center.y, width: 320, height: 213)
                item.center.y = scrollView.center.y
                
            case 4:
                item.frame = CGRect(x: scrollView.frame.origin.x + 1280, y: scrollView.center.y, width: 320, height: 213)
                item.center.y = scrollView.center.y
                
            default:
                item.frame = CGRect(x: scrollView.frame.origin.x, y: scrollView.center.y, width: 320, height: 213)
                item.center.y = scrollView.center.y
                
                
        }
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
        println("scroll view is scrolling")
        println(scrollView.contentOffset)
        var velocity = scrollView.panGestureRecognizer.velocityInView(view)
        
        if scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            if velocity.y > 0 {
                buttonContainerView.alpha += -0.0355   
            }
            
        } else if scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("scroll ended")
           
            }
    
        if scrollView.contentOffset.y <= -44 {
            dismissViewControllerAnimated(true, completion: nil)
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

