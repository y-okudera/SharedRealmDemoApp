//
//  DateFormat.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/25.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

enum DateFormat: String {
    
    case yMd_Hyphen = "yyyy-MM-dd"
    case yMdHms_Hyphen = "yyyy-MM-dd HH:mm:ss"
    case yMdHmsS_Hyphen = "yyyy-MM-dd HH:mm:ss.SSS"
    
    case yMd_Slash = "yyyy/MM/dd"
    case yMdHms_Slash = "yyyy/MM/dd HH:mm:ss"
    case yMdHmsS_Slash = "yyyy/MM/dd HH:mm:ss.SSS"
}
