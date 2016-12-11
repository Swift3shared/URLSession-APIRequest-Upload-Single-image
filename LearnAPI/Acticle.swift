//
//  Acticle.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation
class Acticle{
    var id:Int!
    var title:String!
    var description:String!
    init(id:Int,title:String,description:String) {
        self.id = id
        self.title = title
        self.description = description
    }
    init(title:String,description:String) {        
        self.title = title
        self.description = description
    }
}
