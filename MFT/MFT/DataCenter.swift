//
//  DataCenter.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 22..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import Foundation

struct MFT_Text {
    var keyID: String
    var iconImageName: String
    var text: String?
    
    public func getDicData() -> [String : String] {
        let result : [String : String] = ["keyID" : self.keyID,
                                          "iconImageName" : self.iconImageName,
                                          "text" : self.text ?? ""]
        return result
    }
}

extension MFT_Text {
    init(withDicData myDicData:[String:String]) {
        self.keyID = myDicData["keyID"]!
        self.iconImageName = myDicData["iconImageName"]!
        self.text = myDicData["text"]
    }
}
