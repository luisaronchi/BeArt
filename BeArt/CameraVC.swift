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
        
        //define a view na qual a camera aparece
        CameraManager.sharedInstance.addPreviewLayerToView(self.cameraView)
        //esconde navbar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        //configuracoes da camera
        CameraManager.sharedInstance.cameraOutputMode = .StillImage
        CameraManager.sharedInstance.writeFilesToPhoneLibrary = true //salva no camroll
        CameraManager.sharedInstance.cameraOutputQuality = .High //resolucao
        CameraManager.sharedInstance.showAccessPermissionPopupAutomatically = false //permissao pra acessar camera
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        //tira a foto
        CameraManager.sharedInstance.capturePictureWithCompletition({ (image, error) -> Void in
            self.myImage = image!
        })
    }
    
    @IBAction func playAnimation(sender: AnyObject) {

        var imgListArray = [UIImage]()//cria um vetor de imagems
        
        var bundle : String! = NSBundle.mainBundle().pathForResource("tutorialId1/item_0", ofType: "") //encontra o diretorio onde as frames estão
        let manager = NSFileManager.defaultManager() //aciona o gerenciador de arquivos
        let files = manager.contentsOfDirectoryAtPath(bundle, error: nil) //pega conteudo do diretorio
        var n: Int = files!.count //conta os elementos do conteudo do diretorio
        
        for countValue in 1...n //loop q repete N vezes
        {
            var strImageName = "tutorialId1_item0_frame\(countValue).png" //nome da imagem
            var imagem = UIImage(contentsOfFile: "\(bundle)/\(strImageName)") //seta a imagem atraves do path dela(diretorio)
            imgListArray.append(imagem!)//coloca ela no vetor

        }
        framesView.animationImages = imgListArray as [AnyObject] //As imagens que farão parte da animção são as do vetor
        framesView.animationDuration = 2.0 //tempo de duração da animação
        framesView.animationRepeatCount = 1 //Quantas vezes repete
        framesView.startAnimating() //Depois de configura, Inicia a animacao
    
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
