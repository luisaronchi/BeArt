//
//  DAO.swift
//  BeArt
//
//  Created by Alena Miklos on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation

let _dao : DAO = DAO()

class DAO {
    
    var path = NSBundle.mainBundle().pathForResource("data", ofType: "plist")
    var dict : NSDictionary!;
    
    private init(){
        dict = NSDictionary(contentsOfFile: path!)
    }
    
    class var sharedInstance : DAO {
        return _dao;
    }
    
    func getTutorialList() -> Array<TutorialModel>{
        
        var tutorialList :  Array<TutorialModel> = Array<TutorialModel>()
        
        //traz todos os tutoriais
        var dictTutorials = dict["Tutorials"] as! NSDictionary
        
        //itera dictionary de tutoriais
        for (id, value) in dictTutorials {
            
            var dictTutorial = value as! NSDictionary
            
            //instância de objeto TutoriaModel
            var tutorialModel : TutorialModel = TutorialModel()
            tutorialModel.id = id as! String
            tutorialModel.completed = dictTutorial["completed"] as! Bool
            tutorialModel.name = dictTutorial["name"] as! String
            tutorialModel.stepsCompleted = dictTutorial["stepCompleted"] as! Int
            tutorialModel.nrEtapas = dictTutorial["stepTotal"] as! Int
            
            //pega array de dictionary de steps
            var arraySteps = dictTutorial["steps"] as! NSArray
            
            tutorialModel.stepList = Array<StepModel>()
            
            //passa pela lista de steps 1 a 1
            for (var i = 0; i < arraySteps.count; i++){
                //instância de objeto StepModel
                var stepModel : StepModel = StepModel()
                
                //pega dictionary por posição na lista de steps
                var dictStep = arraySteps[i] as! NSDictionary
                
                //popula objeto de StepModel com dados da plist
                stepModel.id = dictStep["id"] as! String
                stepModel.name = dictStep["name"] as! String
                stepModel.description = dictStep["description"] as! String
                stepModel.frameFolder = dictStep["frameFolder"] as! String
                stepModel.image = dictStep["image"] as! String
                
                //insere objeto populado no array de steps dentro do objeto de TutorialModel
                tutorialModel.stepList.append(stepModel)
            }
            
            //popula lista de tutoriais
            tutorialList.append(tutorialModel)
        }
        
        return tutorialList
        
    }
    
    
}
