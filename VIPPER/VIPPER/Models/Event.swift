//
//  Event.swift
//  MVC
//
//  Created by Manh Pham on 2/8/21.
//

import Foundation

struct Event: Codable {
    
    var id: String?
    var type: String?
    var actor: User?
    var repo: Repository?
        
}
