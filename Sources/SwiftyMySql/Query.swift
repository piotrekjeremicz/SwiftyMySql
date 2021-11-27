//
//  File.swift
//  
//
//  Created by Piotrek on 27/11/2021.
//

import Foundation

extension MySql {
    struct Query {
        let raw: RawQuery
        
        private var mySql: MySql
        internal var printer: Bool = false
        
        init(_ mySql: MySql, raw: RawQuery) {
            self.raw = raw
            self.mySql = mySql
        }
        
        init(_ mySql: MySql, _ builder: Builder) {
            self.raw = builder.raw
            self.mySql = mySql
        }
        
        func print() -> Query {
            Swift.print(raw)
            return self
        }
        
        func printWhenCompleted() -> Query {
            var copy = self
            copy.printer = true
            return copy
        }
        
        func run(completion: @escaping (_ response: Response) -> ()) {
            mySql.execute(query: self, completion: completion)
        }
        
        func queue() {
            mySql.addToQueue(query: self)
        }
    }
}
