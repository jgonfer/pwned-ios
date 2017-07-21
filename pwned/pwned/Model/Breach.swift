//
//  Breach.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Breach: Object, Unboxable {
    // MARK: - Properties
    //dynamic var id: Int64 = 0
    dynamic var name = ""
    dynamic var title = ""
    dynamic var domain = ""
    dynamic var breachDate: Date?
    dynamic var addedDate: Date?
    dynamic var modifiedDate: Date?
    dynamic var pwnCount = 0
    dynamic var descriptionBreach = ""
    //dynamic var dataClasses = ""
    dynamic var isVerified = false
    dynamic var isFabricated = false
    dynamic var isSensitive = false
    dynamic var isRetired = false
    dynamic var isSpamList = false
    dynamic var imageUrl = ""
    
    let baseImageUrl = "https://jgonfer.com/pwned/logos/"
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "name"
    }
    
    // MARK: Init with Unboxer
    convenience required init(unboxer: Unboxer) throws {
        self.init()
        
        name = try unboxer.unbox(keyPath: "Name")
        title = try unboxer.unbox(keyPath: "Title")
        domain = try unboxer.unbox(key: "Domain")
        breachDate = unboxer.unbox(key: "BreachDate", formatter: DateFormatter.breach)
        addedDate = unboxer.unbox(key: "AddedDate", formatter: DateFormatter.breach)
        modifiedDate = unboxer.unbox(key: "ModifiedDate", formatter: DateFormatter.breach)
        pwnCount = try unboxer.unbox(key: "PwnCount")
        descriptionBreach = try unboxer.unbox(key: "Description")
        isVerified = try unboxer.unbox(keyPath: "IsVerified")
        isFabricated = try unboxer.unbox(keyPath: "IsFabricated")
        isSensitive = try unboxer.unbox(keyPath: "IsSensitive")
        isRetired = try unboxer.unbox(keyPath: "IsRetired")
        isSpamList = try unboxer.unbox(keyPath: "IsSpamList")
        imageUrl = "\(baseImageUrl)\(name).png"
    }
    
    static func unboxMany(breaches: [JSONObject]) -> [Breach] {
        return (try? unbox(dictionaries: breaches, allowInvalidElements: true) as [Breach]) ?? []
    }
}
