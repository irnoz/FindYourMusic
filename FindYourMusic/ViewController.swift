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
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // show song details
    }

}

struct Song {
    
}
