//
//  SingleImage.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit
public class SingleImage{
    
    var delegate:delegateProtocol!
    
    func uploadImage(image : UIImage){
        let url = URL(string:"http://120.136.24.174:1301/v1/api/uploadfile/single")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        request.setValue(HEADER, forHTTPHeaderField: ATHENTICATION)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        let image_data = UIImagePNGRepresentation(image)
        if(image_data == nil)
        {
            return
        }
        
        let body = NSMutableData()
        
        let fname = ".jpg"
        let mimetype = "image/png/jpg"
        
        //define the data post parameter
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"FILE\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"FILE\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        print("My body :\n\(body.description)\n")
        
        request.httpBody = body as Data
        
        let data = body as Data
        
        let session = URLSession.shared
        let task = session.uploadTask(with: request, from: data) {
            data, response, error in
            guard let data = data, error == nil else {
                if let error = error as? NSError{
                    print(error)
                    //self.delegate?.niFetchErrorFromClient!(errorMessage : error)
                }
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                //self.delegate?.niFetchDataResponseHTTPEroro!(errorResponse: httpStatus)
                print(httpStatus)
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("**** responseString = \(responseString)")
        }
        task.resume()
    }
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
