//
//  ActicleDetailVC.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit

class ActicleDetailVC: UIViewController, delegateProtocol {
    
    var indexToUpdate:Int = 0
    let acticleContext = AticalConext()
    let singleImage = SingleImage()
    var acticle:Acticle!
    
    @IBOutlet weak var acticleImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        acticleContext.delegate = self
        if acticle != nil {
            titleTextField.text = acticle.title
            descriptionTextField.text = acticle.description
        }
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        singleImage.uploadImage(image: #imageLiteral(resourceName: "image2"))
        print("UPLOAD")
    }
    @IBAction func browImagePress(_ sender: Any) {
    }

    @IBAction func saveActiclePressed(_ sender: Any) {
        if acticle == nil {
            acticle = Acticle(title: titleTextField.text!, description: descriptionTextField.text!)
            acticleContext.postActicle(acticle:acticle)
        }else{
            acticle.title = titleTextField.text!
            acticle.description = descriptionTextField.text!
            acticleContext.editActcle(acticle: acticle)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controllerVC = storyboard.instantiateViewController(withIdentifier: "acticleMainID") as! ActicleVC
            print(indexToUpdate)
            if acticles.count != 0 {
                acticles.remove(at: indexToUpdate)
                acticles.insert(acticle, at: indexToUpdate)
            }
            _ = navigationController?.popViewController(animated: true)
        }
        
        
    }
    func success(data: [String : AnyObject]) {
       
    }
    @IBAction func dismisKeyboard(_ sender: Any) {
        //acticle.title = titleTextField.text!
        //acticle.title = descriptionTextField.text!
    }
    
    func error(data: NSError) {
        print("Errror edit \(data)")
    }
    
    func response(data: HTTPURLResponse) {
        print(data.statusCode)
        if data.statusCode == 200 {
            _ = navigationController?.popViewController(animated: true)
        }
        //print("Response \(data)")
    }
    
    @IBAction func textFieldPress(_ sender: Any) {
//        print("dsvsadfsa")
//        if acticle != nil{
//            acticle.title = titleTextField.text!
//            acticle.title = descriptionTextField.text!
//        }else{
//            acticle = Acticle(title: titleTextField.text!, description: descriptionTextField.text!)
//        }
    }
    
    func successUpload(data: [String : AnyObject]) {
        print("Upload complete : \(data)")
    }
    
    func errorUpload(data: NSError) {
        print("Upload incomplete : \(data)")
    }
    
}
