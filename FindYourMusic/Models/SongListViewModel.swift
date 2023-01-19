//
//  SongListViewModel.swift
//  FindYourMusic
//
//  Created by Irakli Nozadze on 18.01.23.
//

import Combine
import Foundation
import UIKit

class SongListViewModel: ObservableObject {
    // MARK: To Be Changed
    @Published var searchTerm: String = "blind"
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        artworkLoader.reset()
        
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach { self.appendSong(song: $0) }
        }
    }
    
    private func appendSong(song: Song) {
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
        
        artworkLoader.loadArtwork(forSong: song) { image in
            DispatchQueue.main.async {
                songViewModel.artwork = image
            }
        }
    }
    func printSong() {
        print("here\(songs.first?.artistName)")
    }
}

class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    @Published var artwork: UIImageView?
    
    init(song: Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
    }
}
