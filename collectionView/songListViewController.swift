//
//  secondViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/15/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

class songListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var uniqueSongs :[MPMediaItem] = [MPMediaItem]()
    var specificSongs : [MPMediaItem] = [MPMediaItem]()
    var filteredSongs: [MPMediaItem] = [MPMediaItem]()
    var selectListNumber: Int = Int()
    var songs: jamList = jamList()
    var songNumber: Int = Int()
    var resultSearchController = UISearchController()
    //let player = MPMusicPlayerController.applicationMusicPlayer()

    
    @IBOutlet weak var listName: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        listName.text = songs.listname
        var songCollection = MPMediaQuery.songsQuery()
        uniqueSongs = songCollection.items as! [MPMediaItem]
        
        uniqueSongs = uniqueSongs.sorted({ $0.title < $1.title })
        
        if selectListNumber == 1 {
            specificSongs = recentPlayedSongs()
        } else if selectListNumber == 2 {
            specificSongs = mostPlayedSongs()
        }
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.listTableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.listTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MusicCellforSongListView = self.listTableView.dequeueReusableCellWithIdentifier("cell") as! MusicCellforSongListView
        
        if selectListNumber == 0 {
            
        } else if selectListNumber == 1 {
            
            if self.resultSearchController.active == false {
                cell.coverImage.image = specificSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
                cell.mainTitle.text = specificSongs[indexPath.row].title
                cell.subTitle.text = specificSongs[indexPath.row].artist
            } else {
                cell.coverImage.image = self.filteredSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
                cell.mainTitle.text = filteredSongs[indexPath.row].title
                cell.subTitle.text = filteredSongs[indexPath.row].artist
            }
            
        } else if selectListNumber == 2 {
            
            if self.resultSearchController.active == false {
                cell.coverImage.image = specificSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
                cell.mainTitle.text = specificSongs[indexPath.row].title
                cell.subTitle.text = specificSongs[indexPath.row].artist
            } else {
                cell.coverImage.image = self.filteredSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
                cell.mainTitle.text = filteredSongs[indexPath.row].title
                cell.subTitle.text = filteredSongs[indexPath.row].artist
            }
        } else {
            
        }
                
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        if searchController.searchBar.text != "" {
        self.filteredSongs.removeAll(keepCapacity: false)
        filterSongs(searchController.searchBar.text)
//
//        var searchText = searchController.searchBar.text!
//        
//        var titlePredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyTitle, comparisonType: .Contains)
//        
//        var albumPredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: .Contains)
//        
//        var artistPredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyArtist, comparisonType: .Contains)
//        
//        var query = MPMediaQuery.songsQuery()
//        query.addFilterPredicate(titlePredicate)
//        filteredSongs = query.items as! [MPMediaItem]
//        query = MPMediaQuery.songsQuery()
//        query.addFilterPredicate(albumPredicate)
//        filteredSongs += query.items as! [MPMediaItem]
//        query = MPMediaQuery.songsQuery()
//        query.addFilterPredicate(artistPredicate)
//        filteredSongs += query.items as! [MPMediaItem]
//        
//        filteredSongs = Array(Set(filteredSongs))
        
        self.listTableView.reloadData()
        
    }
    
    func filterSongs(searchText: String) {
        //self.filteredSongs = [MPMediaItem]()
        self.filteredSongs = uniqueSongs.filter({
            (song: MPMediaItem) -> Bool in
            return song.title.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || song.albumArtist.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || song.albumTitle.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
    }

    
    func mostPlayedSongs() -> [MPMediaItem] {
        var mostPlayedSong: [MPMediaItem] = [MPMediaItem]()
        for var index = 0; index < uniqueSongs.count; index++ {
            mostPlayedSong.append(uniqueSongs[index])
            println(uniqueSongs[index].title)
            println(uniqueSongs[index].playCount)
        }
        mostPlayedSong = mostPlayedSong.sorted({ $0.playCount > $1.playCount })
//        var countArray: [Int] = [Int]()
//        for var index = 0; index < uniqueSongs.count; index++ {
//            countArray[index] = uniqueSongs[index].playCount
//        }
        
        
        
        return mostPlayedSong
    }
    
    func recentPlayedSongs() -> [MPMediaItem] {
        var recentPlayedSong: [MPMediaItem] = [MPMediaItem]()
        for var index = 0; index < uniqueSongs.count; index++ {
            if uniqueSongs[index].lastPlayedDate != nil {
                recentPlayedSong.append(uniqueSongs[index])
            }
            println(uniqueSongs[index].title)
            println(uniqueSongs[index].lastPlayedDate)
        }
        recentPlayedSong = recentPlayedSong.sorted({ $0.lastPlayedDate.compare($1.lastPlayedDate) == NSComparisonResult.OrderedDescending })

        //        var dateArray: [NSDate] = [NSDate]()
//        for var index = 0; index < uniqueSongs.count; index++ {
//            dateArray.append(uniqueSongs[index].lastPlayedDate)
//        }
        
        return recentPlayedSong
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active == true {
            return self.filteredSongs.count
        } else {
            return specificSongs.count
        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var items = [MPMediaItem]()
//        if self.resultSearchController.active == false {
//            items.append(specificSongs[indexPath.row])
//            var collection = MPMediaItemCollection(items: items)
//            player.setQueueWithItemCollection(collection)
//        } else {
//            items.append(filteredSongs[indexPath.row])
//            var collection = MPMediaItemCollection(items: items)
//            player.setQueueWithItemCollection(collection)
//        }
        
    }
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            // handle delete (by removing the data from your array and updating the tableview)
//
//        }
//    }
    

    @IBAction func backToJamList(sender: AnyObject) {
//        var jamListView = storyboard?.instantiateViewControllerWithIdentifier("jamList") as! jamListViewController
        //jamListView.numberArray[selectListNumber] = "\(selectListNumber)"
        MPMusicPlayerController().stop()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
