//
//  File.swift
//  
//
//  Created by Piotrek on 27/11/2021.
//

import Foundation

extension MySql {
    struct Response {
        let raw: RawResponse
        
        init(_ mySql: MySql, raw: RawResponse) {
            self.raw = raw
        }
        
        func decode<T>(_ type: T.Type) -> T? where T : Decodable {
            if let decoded = try? JSONDecoder().decode(T.self, from: raw) {
                return decoded
            } else {
                print("Unable to decode: \(String(data: raw, encoding: .utf8) ?? "-")")
                return nil
            }
        }
    }
}
