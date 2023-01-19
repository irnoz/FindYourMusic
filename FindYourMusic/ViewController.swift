//
//  ViewController.swift
//  FindYourMusic
//
//  Created by Irakli Nozadze on 18.01.23.
//

import UIKit

// User Interface (tableView for list of results and a field to search for songs)
// network request to get information about songs from spotify API
// gesture recogniser to see detailed info about a song
// custom cell to show music info

class ViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    private let songListViewModel: SongListViewModel = SongListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        songListViewModel.printSong()
        
        tableView.register(SongTableViewCell.nib(), forCellReuseIdentifier: SongTableViewCell.identifier)
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    // textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMusic()
        
        return true
    }
    
    func searchMusic() {
        textField.resignFirstResponder()

        guard let text = textField.text, !text.isEmpty else {
            print("Error: text field nil or empty")
            return
        }
        
//        URLSession.shared.dataTask(with: URL(string: "https://itunes.apple.com/search?term=blind&entity=song")!, completionHandler: { data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            // convert data
//
//            // update songs array
//
//            // refrresh our table
//
//        }).resume()
        
    }
    
    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songListViewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as! SongTableViewCell
        cell.configure(with: songListViewModel.songs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // show song details
    }

}

