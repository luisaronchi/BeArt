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
    @IBOutlet weak var opacitySlider: UISlider!
    
    
    var step : StepModel = StepModel();
    
    var myImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //transforma o slider em vertical
        var trans : CGAffineTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        opacitySlider.transform = trans;
        
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

        var imgListArray = [UIImage]()//cria um vetor de imagens
        
        var bundle : String! = NSBundle.mainBundle().pathForResource(step.idTutorial + "/" + step.frameFolder, ofType: "") //encontra o diretorio onde as frames estão
        let manager = NSFileManager.defaultManager() //aciona o gerenciador de arquivos
        let files = manager.contentsOfDirectoryAtPath(bundle, error: nil) //pega conteudo do diretorio
        var n: Int = files!.count //conta os elementos do conteudo do diretorio
        
        for countValue in 0...(n-1) //loop q repete N vezes
        {
            var strImageName = step.idTutorial + "_" + step.frameFolder + "_frame\(countValue).png" //nome da imagem
            var imagem = UIImage(contentsOfFile: "\(bundle)/\(strImageName)") //seta a imagem atraves do path dela(diretorio)
            imgListArray.append(imagem!)//coloca ela no vetor
        }
        
        if  n <= 50 {
        
        framesView.animationImages = imgListArray as [AnyObject]
        framesView.animationDuration = 10.0 //tempo de duração da animação
        framesView.animationRepeatCount = 0 //Quantas vezes repete
        framesView.startAnimating() //Depois de configura, Inicia a animacao
        //As imagens que farão parte da animção são as do vetor
            
        }
        
        else {
            
        framesView.animationImages = imgListArray as [AnyObject]
        framesView.animationDuration = 30.0 //tempo de duração da animação
        framesView.animationRepeatCount = 0 //Quantas vezes repete
        framesView.startAnimating() //Depois de configurar, inicia a animacao
        //As imagens que farão parte da animção são as do vetor
        //if statement pra mudar a velocidade da animação de acordo com a quantidade de frames
    
        }
        
    }
    
    @IBAction func opacity(sender: AnyObject) {
    
        let sliderValue = CGFloat(opacitySlider.value)
        self.framesView.alpha = sliderValue
    
    }
    
    
    
    
    @IBAction func back(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

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
