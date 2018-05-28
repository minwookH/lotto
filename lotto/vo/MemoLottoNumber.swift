//
//  MemoLottoNumber.swift
//  lotto
//
//  Created by teruten on 2018. 5. 14..
//  Copyright © 2018년 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MemoLottoNumber: Object {
    
    var result: String?
    var date: Date?
    var number1: String?
    var number2: String?
    var number3: String?
    var number4: String?
    var number5: String?
    var number6: String?
    
    //    required init?(map: Map) {
    //        if map.JSON["member"] == nil {
    //            print("not member")
    //        }else{
    //            print("member exist")
    //        }
    //    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
//    // Mappable
//    func mapping(map: Map) {
//        memberList        <- map["member"]
//        result            <- map["result"]
//    }
}
