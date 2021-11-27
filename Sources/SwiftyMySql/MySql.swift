//
//  File.swift
//  
//
//  Created by Piotrek on 27/11/2021.
//

import Foundation

class MySql {
    typealias RawQuery = String
    typealias RawResponse = Data
    
    var queue = Queue()
    
    func query(raw: RawQuery) -> Query {
        MySql.Query(self, raw: raw)
    }
    
    func query(_ builder: MySql.Query.Builder) -> Query {
        MySql.Query(self, builder)
    }
    
    func addToQueue(query: MySql.Query) {
        queue.add(query: query)
    }
    
    func addToQueue(_ builder: MySql.Query.Builder) {
        queue.add(query: MySql.Query(self, builder))
    }
    

    func execute(query: Query, completion: @escaping (_ response: Response) -> ()) {
        let shPath = Bundle.main.path(forResource: "Query", ofType: "php")
        
        DispatchQueue.global().async {
            let task = Process()
            task.launchPath = "/usr/bin/php"
            task.arguments = ["\(shPath!)", query.raw]
            
            let pipe = Pipe()
            task.standardOutput = pipe
            task.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            task.terminationHandler = { _ in
                if query.printer { Swift.print(query.raw) }
                completion(Response(self, raw: data))
            }
        }
    }
}


