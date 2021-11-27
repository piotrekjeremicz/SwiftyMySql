//
//  File.swift
//  
//
//  Created by Piotrek on 27/11/2021.
//

import Foundation

extension MySql.Query {
    struct Builder {
        var raw: MySql.RawQuery = ""
        
        static func queue(_ queue: String) -> Builder {
            return Builder(raw: queue)
        }
        
        static func call(_ function: String, parameters: String...) -> Builder {
            let stringParameters = parameters.map({ "\($0.lowercased() == "null" || $0.isEmpty ? "\($0)" : "'\($0)'")" }).joined(separator: ", ")
            
            return Builder(raw: "CALL " + function + "(" + stringParameters + ");")
        }
    }
}
