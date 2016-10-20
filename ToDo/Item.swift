//
//  Item.swift
//  ToDo
//
//  Created by Robert Chang on 10/16/16.
//  Copyright © 2016 Bobert. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var uuid: String = NSUUID().uuidString
    var name: String = ""
    var doing: String = ""
    var checked = false
    var date = Date()
    
    init(name: String, doing: String) {
        super.init()
        
        self.name = name
        self.doing = doing
        self.date = Date()    }

    
    required init?(coder decoder: NSCoder) {
        
        super.init()
        
        if let archivedUuid = decoder.decodeObject(forKey: "uuid") as? String {
            uuid = archivedUuid
        }
        if let archivedName = decoder.decodeObject(forKey: "name") as? String {
            name = archivedName
            
            print (archivedName)
            
        }
        
        if let archivedDoing = decoder.decodeObject(forKey: "doing") as? String {
            doing = archivedDoing
        }
        
        if let archivedDate = decoder.decodeObject(forKey: "date") as? Date {
            date = archivedDate
        }

        
        checked = decoder.decodeBool(forKey: "checked")
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey: "uuid")
        coder.encode(name, forKey: "name")
        coder.encode(doing, forKey: "doing")
        coder.encode(date, forKey: "date")
        coder.encode(checked, forKey: "checked")
    }
    
}

