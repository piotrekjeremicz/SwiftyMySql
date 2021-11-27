//
//  File.swift
//  
//
//  Created by Piotrek on 27/11/2021.
//

import Foundation

extension MySql {
    class Queue {
        var queries: [Query] = []
                
        func add(query: Query) {
            queries.append(query)
        }
        
        func run(step: @escaping (_ response: Response) -> (), completion: @escaping () -> ()) {
            guard let query = queries.first else { completion(); return }
            
            query.run { [self] response in
                step(response)
                queries.removeFirst()
                run(step: step, completion: completion)
            }
        }
    }
}
