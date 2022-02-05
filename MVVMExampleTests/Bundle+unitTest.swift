//
//  Bundle+unitTest.swift
//  MVVMExampleTests
//
//  Created by Mac on 1/31/22.
//

import Foundation

extension Bundle {

    public class var unitTest:Bundle{
        return Bundle(for:APIServicesTest.self)
    }
}
