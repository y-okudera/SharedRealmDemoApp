//
//  ExceptionCatchable.swift
//  SharedRealmDemoApp
//
//  Created by YukiOkudera on 2019/08/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

protocol ExceptionCatchable {}

extension ExceptionCatchable {
    func execute(_ tryBlock: () -> ()) throws {
        try ExceptionHandler.catchException(try: tryBlock)
    }
}
