//
//  TutorialVC.swift
//  BeArt
//
//  Created by Luisa Carvalho de Mendonça Ronchi on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tutorialList : Array<TutorialModel>!
    
    @IBOutlet var tableView: UITableView!
    var stepSelected : StepModel = StepModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background1.png")!)
        
        
        
        tutorialList =  DAO.sharedInstance.getTutorialList()
    
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "celTapped:", name:"tapCell", object: nil)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    
    //segue para a pagina "how to"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toHow" {
            
            var howToVC = segue.destinationViewController as! HowToVC
            
            
        } else {
            
            var cameraVC : CameraVC = segue.destinationViewController as! CameraVC
            cameraVC.step = stepSelected
        }
        
        
    }
    
    
    func celTapped(notification: NSNotification){
        
        println("celTapped")
        stepSelected = notification.object as! StepModel

        performSegueWithIdentifier("toCamera", sender: self)
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "tapCell", object: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var textLabel: UILabel!

        var celula : TutorialCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! TutorialCell
        
        //celula.textLabel?.text = tutorialList[indexPath.row].name
        //celula.textLabel?.frame = CGRectMake(0, 0, 100, 100)
        //celula.label.text = tutorialList[indexPath.row].name
        //celula.label.font = UIFont (name: "desyrel", size: 17)
        
        celula.textLabel?.text = tutorialList[indexPath.row].name
        celula.textLabel?.font = UIFont (name: "desyrel", size: 40)
        
        celula.listSteps = tutorialList[indexPath.row].stepList
        celula.tutorialIndex = indexPath.row + 1
    
        celula.backgroundColor = UIColor.clearColor()  // Adding this fixes the issue for iPad
        
  
        //var scrollview = UIScrollView(frame: celula.bounds)
        //scrollview.contentSize = CGSizeMake(celula.bounds.width * 5, celula.bounds.height) // will be 5 times as wide as the cell
        //scrollview.pagingEnabled = true
        //celula.contentView.addSubview(scrollview)
        
        return celula

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
