//
//  delegateProtocole.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation

@objc protocol  delegateProtocol {
    @objc optional func success(data:[String:AnyObject])
    @objc optional func error(data:NSError)
    @objc optional func response(data:HTTPURLResponse)
    @objc optional func successDelete(data:AnyObject)
    @objc optional func successUpload(data:[String:AnyObject])
    @objc optional func errorUpload(data:NSError)
}

var acticles:[Acticle] = []
