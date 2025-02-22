//
//  File.swift
//  Stress_Relief_App
//
//  Created by Batch -2  on 13/02/25.
//

import Foundation

struct Memory: Identifiable {
    var id = UUID() 
    var title: String
    var description: String
    var date: Date
    var imageData: Data?
    var audioData: Data?
    var videoURL: URL?
    
    init(title: String, description: String, date: Date, imageData: Data? = nil, audioData: Data? = nil, videoURL: URL? = nil) {
        self.title = title
        self.description = description
        self.date = date
        self.imageData = imageData
        self.audioData = audioData
        self.videoURL = videoURL
    }
}

struct SoundData {
    static let sounds = [
        (name: "Raindrop Serenity", file: "Rain"),
        (name: "Birdsong Bliss", file: "Bird"),
        (name: "Lovely Whispers", file: "Relaxing Sound"),
        (name: "Piano Tranquility", file: "Peace Sound")
    ]
}

