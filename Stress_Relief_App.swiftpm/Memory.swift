//
//  File.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 13/02/25.
//

import Foundation

struct Memory: Identifiable, Codable {
    var id = UUID()
    var title: String
    let description: String
    let date: Date
    var imageData: Data?
}
