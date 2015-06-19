//
//  CameraVC.swift
//  BeArt
//
//  Created by Luisa Carvalho de Mendonça Ronchi on 21/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
//import CameraManager

class CameraVC: UIViewController
{
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var framesView: UIImageView!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet var speedSlider: UISlider!
    
    var botone : UIButton!;

    
    
    @IBAction func savePhoto(sender: AnyObject) {
        capturePicture()
    }
  
    var stillImageOutput = AVCaptureStillImageOutput()
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    
    var frameSpeed : Float!;
    var frameIndex : Int = 0;
    var isPaused : Bool = false;
    var started : Bool = false;
    var timerCount : Int = 0;
    
    
    var step : StepModel = StepModel();
    var myImage = UIImage()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //transforma o slider em vertical
        var trans : CGAffineTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        opacitySlider.transform = trans;
        
        //esconde navbar
        //navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        //configs da camera
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices
        {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo))
            {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back)
                {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil
                    {
                        println("Capture device found")
                        beginSession()
                    }
                }
            }
        }
        
    }
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    
                })
                device.unlockForConfiguration()
            }
        }
    }
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        var anyTouch = touches.first! as! UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        var anyTouch = touches.first as! UITouch
        
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    
    func configureDevice()
    {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
        
    }
    
    func beginSession()
    {
        
        configureDevice()
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        cameraView.backgroundColor = UIColor.blackColor()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill;

        previewLayer?.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        cameraView.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        //fim das configs da camera
    }
    
    
    @IBAction func playAnimation(sender: UIButton) {
        
        botone = sender;
        
//        
//        if sender.titleLabel!.text == "Play"{
//            sender.setTitle("Play", forState: UIControlState.Normal)
        
        
            
            // if  n <= 50 {
        
        
        if(!started){
            
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
            
            started = true;
            frameIndex = 0;
            
            //a velocidade mais devagar é 3 segundos por frame
            speedSlider.maximumValue = 3.0 //valor maximo(depende do numero de frames)
            speedSlider.value = speedSlider.maximumValue/2 //valor inicial é sempre a metade da mais devagar
            framesView.animationImages = imgListArray as [AnyObject]
            frameSpeed = speedSlider.maximumValue - speedSlider.value
            framesView.image = framesView.animationImages?.first as? UIImage;
            sender.selected = true;
            processAnimation();
            
        }
        else{
            if(isPaused){
                sender.selected = true;
                processAnimation();
                isPaused = false;
            }
            else{
                sender.selected = false;
                isPaused = true;
            }
        }
        
        
        
        
        
            /*
            framesView.animationDuration = NSTimeInterval(speedSlider.maximumValue - speedSlider.value) //tempo de duração da animação - PS: valor maximo na vdd tem que ser o minimo, entao tem que fazer essa subtração pra inverter
            framesView.animationRepeatCount = 0 //Quantas vezes repete
            framesView.startAnimating() //Depois de configura, Inicia a animacao
            //As imagens que farão parte da animção são as do vetor

            */
        
        
        
        }
//        else{
//            sender.setTitle("Play", forState: UIControlState.Normal)
//            
//            
//        }
//    }
    
    func processAnimation(){
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(frameSpeed), target: self, selector: Selector("nextFrame"), userInfo: nil, repeats: false)
        timerCount++;
        
    }
    
    func nextFrame(){
        if(timerCount>1){
            timerCount--;
            return;
        }
        if(isPaused){
            timerCount--;
            return;
        }
        frameIndex++;
        if(frameIndex >= framesView.animationImages?.count){
            timerCount--;
            botone.selected = false;
            
            //TRECHO PARA FAZER COISINHAS QUANDO A IMAGEM TERMINAR DE RODAR AS ANIMACOES TODAS
            fazerCoisinhas();
            
            return;
        }
        framesView.image = framesView.animationImages?[frameIndex] as? UIImage;
        var timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(frameSpeed), target: self, selector: Selector("nextFrame"), userInfo: nil, repeats: false)
    }
    
    //slider de opacidade
    @IBAction func opacity(sender: AnyObject) {
    
        let sliderValue = CGFloat(opacitySlider.value)
        self.framesView.alpha = sliderValue
    
    }
 
    func fazerCoisinhas(){
        
    }

    
    @IBAction func back(sender: UIButton) {

        
        
//        self.navigationController?.popViewControllerAnimated(true)
//        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    
    func capturePicture(){
        
        println("Capturing image")
        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        //stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
        
        ///captureSession.addOutput(stillImageOutput)
        
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo){
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                var dataProvider = CGDataProviderCreateWithCFData(imageData)
                var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
                var image = UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Right)
                
                var imageView = UIImageView(image: image)
                imageView.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: self.view.frame.height)
                
                //Save the captured preview to image
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                
            })
        }
    }
    
    //slider VELOCIDADE
    @IBAction func speed(sender: AnyObject) {
        
        
        frameSpeed = speedSlider.maximumValue - speedSlider.value
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //    @IBAction func back(sender: UIButton) {
    //
    //        self.navigationController?.popViewControllerAnimated(true)
    //        navigationController?.setNavigationBarHidden(false, animated: false)
    //
    //    }
    
    //https://github.com/imaginary-cloud/CameraManager
    
    //define a view na qual a camera aparece
    //        CameraManager.sharedInstance.addPreviewLayerToView(self.cameraView)

    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
