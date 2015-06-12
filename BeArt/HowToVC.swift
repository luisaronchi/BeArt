//
//  HowToVC.swift
//  BeArt
//
//  Created by Alena Miklos on 22/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class HowToVC: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate {
    
    
@IBOutlet weak var collectionSupport: UICollectionView!
var materialList = ["how1.png", "how2.png", "how3.png", "how4.png", "how5.png"] //lista com nomes das imagens

override func viewDidLoad() {
    super.viewDidLoad()


    
    self.collectionSupport.dataSource = self
    self.collectionSupport.delegate = self
    
        self.collectionSupport.registerClass( SupportCell.self, forCellWithReuseIdentifier: "support")

    }



    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return materialList.count
    }



    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let tripe = collectionView.dequeueReusableCellWithReuseIdentifier("support", forIndexPath: indexPath) as! SupportCell
        
        let supportType = UIImageView()                 //criando image view
        supportType.frame = tripe.frame                //setando o tamanho da image view(igual ao da celula)
        supportType.image = UIImage(named: materialList[indexPath.row])//setando a image da image view
        //UIImage busca pelo nome da imagem, entao basta passar o nome da imagem pra ela.
        tripe.addSubview(supportType)                   //colocando a imageview na celula
        
        return tripe
    }
}

