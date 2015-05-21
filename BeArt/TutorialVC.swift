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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialList =  DAO.sharedInstance.getTutorialList()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var celula : TutorialCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! TutorialCell
        
        celula.textLabel?.text = tutorialList[indexPath.row].name
        celula.textLabel?.frame = CGRectMake(0, 0, 100, 100)
        
        celula.listSteps = tutorialList[indexPath.row].stepList
    
        return celula
        
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
