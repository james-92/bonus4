

import Foundation
import AVFoundation

class song{
    var songName:String
    var singer:String
    var cover:String
    var backgroundColor:[CGColor]
    init(songName: String, singer: String, cover: String, backgroundColor:[CGColor]) {
        self.songName = songName
        self.singer = singer
        self.cover = cover
        self.backgroundColor = backgroundColor
    }
}



