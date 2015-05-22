//
//  CameraVC.swift
//  BeArt
//
//  Created by Luisa Carvalho de Mendonça Ronchi on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MobileCoreServices
import CameraManager

class CameraVC: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var framesView: UIImageView!
    
    var myImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//https://github.com/imaginary-cloud/CameraManager
        

        CameraManager.sharedInstance.addPreviewLayerToView(self.cameraView)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        CameraManager.sharedInstance.cameraOutputMode = .StillImage
        CameraManager.sharedInstance.writeFilesToPhoneLibrary = true
        CameraManager.sharedInstance.cameraOutputQuality = .High
        CameraManager.sharedInstance.showAccessPermissionPopupAutomatically = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        CameraManager.sharedInstance.capturePictureWithCompletition({ (image, error) -> Void in
            self.myImage = image!
        })

        
        
    }
    
    @IBAction func playAnimation(sender: AnyObject) {

        var imgListArray :NSMutableArray = []
        
        for countValue in 1...5
        {
            
            var strImageName : String = "\(countValue)StarsSmall.png"
            var image  = UIImage(named:strImageName)

            imgListArray .addObject(image!)

            framesView.animationImages = imgListArray as [AnyObject]
            framesView.animationDuration = 2.0
            framesView.animationRepeatCount = 1
            framesView.startAnimating()
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
