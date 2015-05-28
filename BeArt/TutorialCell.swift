//
//  TutorialCell.swift
//  BeArt
//
//  Created by Luisa Carvalho de Mendonça Ronchi on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class TutorialCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var index:Int?
    
    var listSteps : Array<StepModel>!
    var tutorialIndex : Int!;
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSteps.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let picture = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! StepCell
        
        // step.idTutorial + "/" + step.frameFolder
        
        let step = listSteps[indexPath.row]
        
        picture.stepPicture.image = UIImage(named: "tutorialId\(self.index!)/item\(indexPath.row)/" + listSteps[indexPath.row].image + ".png")
        
        
        println("tutorialId\(self.index!)/item\(indexPath.row)/" + listSteps[indexPath.row].image + ".png")
        

        picture.tag = indexPath.row;

        return picture
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //criamos objeto com informações da etapa selecionada
        var step : StepModel = StepModel();
        step.id = "step\(indexPath.row + 1)Tutorial\(tutorialIndex)"
        step.frameFolder = "item\(indexPath.row)"
        step.idTutorial = "tutorialId\(tutorialIndex)"
        
        //criamos uma notificação com identifier =  tapCell para ser 
        //visto pelo ViewController que observar essa notifação
        
        println("didSelectItemAtIndexPath")
        NSNotificationCenter.defaultCenter().postNotificationName("tapCell", object: step)
        
    }
    
    
    
}
