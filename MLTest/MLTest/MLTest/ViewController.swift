//
//  ViewController.swift
//  MLTest
//
//  Created by qianbingzhen on 2019/5/31.
//  Copyright © 2019年 qian. All rights reserved.
//

import UIKit
import CoreML
class ViewController: UIViewController,UINavigationControllerDelegate {
    @IBOutlet weak var classfiler:UILabel!
    @IBOutlet weak var imageView: UIImageView!
//    var model:YOLOv3Tiny!
    var model:SqueezeNet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        model = SqueezeNet()
    }
    @IBAction func openLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true) {
            
        }
    }
    
    @IBAction func camera(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            return
        }
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        present(cameraPicker, animated: true) {
            
        }
    }
}
extension ViewController:UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        dismiss(animated: true) {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {}
        classfiler.text = "Analyzing Image..."
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 227, height: 227), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 227, height: 227))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage
//        guard let prediction = try?model.prediction(image: pixelBuffer!, iouThreshold: 1.0, confidenceThreshold: 1.0)else{
//            return
//        }
        guard let prediction = try?model.prediction(image: pixelBuffer!)else{
            return
        }

        classfiler.text = "I think this is a \(prediction.classLabel)"
        
    }
}
