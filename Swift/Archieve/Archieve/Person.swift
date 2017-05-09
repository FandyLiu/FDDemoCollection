//
//  Person.swift
//  Archieve
//
//  Created by QianTuFD on 2017/4/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
    }
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")
    }

    var name: String = ""
    var age: Int = 0
    
    func save(per: Person) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/person")
        NSKeyedArchiver.archiveRootObject(per, toFile: path!)
    }
    
    func read() -> Person {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/person")
        return NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! Person
    }
    

}
