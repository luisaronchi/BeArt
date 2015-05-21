//
//  TutorialModel.swift
//  BeArt
//
//  Created by Alena Miklos on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation 

class TutorialModel {
    
    var id: String!
    var name: String!
    var nrEtapas: Int!
    var stepsCompleted: Int!
    var completed: Bool!
    var stepList: Array <StepModel>!
}