//
//  AticalContext.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation

public class AticalConext{
    
    //var task:URLSession!
    
    var delegate:delegateProtocol!
    
    func fetchAtical(){
        // step 1 create url for request
        let url = URL(string:ATICAL_URL)
        // step 2 create http Request for prepare httpRequest to server
        var httpRequest = URLRequest(url:url!)
        
        //httpRequest.addValue(HEADER, forHTTPHeaderField: ATHENTICATION) // add header
        //httpRequest.addValue("*/*", forHTTPHeaderField: "Accept") // add Accept header
        httpRequest.httpMethod = "GET" // add method
        
        httpRequest.allHTTPHeaderFields = [
            "Authorization":"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
            "Accept":"*/*"
        ]
        
        
        let session = URLSession.shared
        session.dataTask(with: httpRequest, completionHandler: {(responseBody, httpResponse, error) in
            
            if error == nil { // if error == nothing it mean data is not nothing 
                let json = try! JSONSerialization.jsonObject(with: responseBody!, options: .allowFragments) as! [String:AnyObject]
                self.delegate?.success!(data: json) // notify when data is respone
                //print("This is my json body response : \(json)")
            }
            else {
                //print("Here is my error response : \(error)")
                self.delegate?.error!(data: error as! NSError)
            }
            if let httpResponse = httpResponse  {
                self.delegate?.response!(data: httpResponse as! HTTPURLResponse)
                //print("Here is my response http : \(httpResponse)")
                
            }
        }).resume()
    }
    
    func postActicle(acticle:Acticle) {
        let url = URL(string:"http://120.136.24.174:1301/v1/api/articles")
        var httpRequest = URLRequest(url:url!)
        
        httpRequest.allHTTPHeaderFields = ["Content-Type": "application/json","Accept": "*/*", "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        httpRequest.httpMethod = "POST"
        
        let paramater = [
            "TITLE": "\(acticle.title)",
            "DESCRIPTION": "\(acticle.description)",
            "AUTHOR": 0,
            "CATEGORY_ID": 0,
            "STATUS": "string",
            "IMAGE": "string"
            ] as AnyObject
        
        let dataParamater = try! JSONSerialization.data(withJSONObject: paramater, options: [])
        httpRequest.httpBody = dataParamater
        let session = URLSession.shared
        
        session.dataTask(with: httpRequest){
            responseBody, httpResponse, error in
                if error == nil { // if error == nothing it mean data is not nothing
                    let json = try! JSONSerialization.jsonObject(with: responseBody!, options: .allowFragments)
                    print("This is my json body response : \(json)")
                }
                else {
                    print("Here is my error response : \(error)")
                }
                if let httpResponse = httpResponse  {
                    print("Here is my response http : \(httpResponse)")
                }
        }.resume()
        //self.task.suspend()
    }
    
    func deleteActicle(id:Int){
        // step 1 create url for request
        let url = URL(string:"http://120.136.24.174:1301/v1/api/articles/\(id)" )
        // step 2 create http Request for prepare httpRequest to server
        var httpRequest = URLRequest(url:url!)
        
        //httpRequest.addValue(HEADER, forHTTPHeaderField: ATHENTICATION) // add header
        //httpRequest.addValue("*/*", forHTTPHeaderField: "Accept") // add Accept header
        httpRequest.httpMethod = "GET" // add method
        
        httpRequest.allHTTPHeaderFields = [
            "Authorization":"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
            "Accept":"*/*"
        ]
        
        
        let session = URLSession.shared
        session.dataTask(with: httpRequest, completionHandler: {(responseBody, httpResponse, error) in
            
            if error == nil { // if error == nothing it mean data is not nothing
                let json = try! JSONSerialization.jsonObject(with: responseBody!, options: .allowFragments) as! [String:AnyObject]
                self.delegate?.successDelete!(data: json as AnyObject)
                //print("This is my json body response : \(json)")
            }
            else {
                //print("Here is my error response : \(error)")
                self.delegate?.error!(data: error as! NSError)
            }
            if let httpResponse = httpResponse  {
                self.delegate?.response!(data: httpResponse as! HTTPURLResponse)
                //print("Here is my response http : \(httpResponse)")
                
            }
        }).resume()
    }
    func editActcle(acticle:Acticle){
        let url = URL(string:"http://120.136.24.174:1301/v1/api/articles/\(acticle.id!)")
        var httpRequest = URLRequest(url:url!)
        
        httpRequest.allHTTPHeaderFields = ["Content-Type": "application/json","Accept": "*/*", "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        httpRequest.httpMethod = "PUT"
    
        let paramater = [
                "TITLE": acticle.title,
                "DESCRIPTION": acticle.description,
                "AUTHOR": 0,
                "CATEGORY_ID": 0,
                "STATUS": "string",
                "IMAGE": "string"
            ] as AnyObject
    
        let dataParamater = try! JSONSerialization.data(withJSONObject: paramater, options: [])
        httpRequest.httpBody = dataParamater
        let session = URLSession.shared
    
        session.dataTask(with: httpRequest){
            responseBody, httpResponse, error in
            if error == nil { // if error == nothing it mean data is not nothing
                let json = try! JSONSerialization.jsonObject(with: responseBody!, options: .allowFragments) as! [String:AnyObject]
                //print("This is my json body response : \(json)")
                self.delegate?.success!(data: json)
            }
            else {
                //print("Here is my error response : \(error)")
                self.delegate?.error!(data: error as! NSError)
            }
            if let httpResponse = httpResponse  {
                //print("Here is my response http : \(httpResponse)")
                self.delegate?.response!(data: httpResponse as URLResponse as! HTTPURLResponse)
            }
        }.resume()
    }
}
