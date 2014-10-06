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
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePhotImageView()
        configureScrollView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Configuration
    
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
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: 320, height: 585)
        scrollView.contentOffset.y = 44
        scrollView.contentInset = UIEdgeInsets(top: -46, left: 0, bottom: -44, right: 0)
        scrollView.delegate = self
    }
    
    // MARK: Scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("scroll view is scrolling")
        var window = UIApplication.sharedApplication().keyWindow
        
        if scrollView.dragging {
            buttonContainerView.alpha += -0.025
        } else {
            buttonContainerView.alpha = 1
        }
        println(scrollView.dragging)
    }
    
    // MARK: Actions

    @IBAction func onDoneButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
