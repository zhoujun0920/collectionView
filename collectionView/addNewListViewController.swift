//
//  addNewListViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/17/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

class addNewListViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating {
    
    var uniqueSongs :[MPMediaItem] = [MPMediaItem]()
    var filteredSongs: [MPMediaItem] = [MPMediaItem]()
    var resultSearchController = UISearchController()
    //var sorteduniqueSongs: [MPMediaItem]!
    //let sectionsTableidentifier = "SectionsTableIdentfier"
    //var keys: [String] = [String]()
    //var sortedKeys: [String] = [String]()
    //var names: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    //var searchController: UISearchController!
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var imagePicker: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
        
        coverImage.layer.borderWidth = 1
        var songCollection = MPMediaQuery.songsQuery()
        uniqueSongs = songCollection.items as! [MPMediaItem]//(songCollection.items as! [MPMediaItem]).filter({song in song.playbackDuration > 30 })

        addTableView.allowsMultipleSelection = true
        
        //sort song by alphabetical
        uniqueSongs = uniqueSongs.sorted{ $0.title < $1.title }
        //reorganizeTable()
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.addTableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.addTableView.reloadData()
        
        //search bar
//        let resultsController = SearchResultsController()
//        resultsController.names = uniqueSongs
//        //resultsController.keys = keys
//        
//        searchController = UISearchController(searchResultsController: resultsController)
//        let resultsSearchView = searchController.searchBar
//        //resultsSearchView.scopeButtonTitles = ["All", "Short", "Long"]
//        resultsSearchView.placeholder = "Enter a search term"
//        resultsSearchView.sizeToFit()
//        addTableView.tableHeaderView = resultsSearchView
//        searchController.searchResultsUpdater = resultsController
        //searchResultView.addSubview(searchDisplayController?.searchResultsTableView)
        //self.searchDisplayController?.searchResultsTableView
//        
//        addTableView.sectionIndexBackgroundColor = UIColor.blackColor()
//        addTableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
//        addTableView.sectionIndexColor = UIColor.whiteColor()
    
    }
    
/*
    func reorganizeTable() {
        let specialKey = "Others"
        
        var firstLetter: String = String()
        var temp: [MPMediaItem] = [MPMediaItem]()
        if uniqueSongs.count != 0 {
            firstLetter = (uniqueSongs[0].title as NSString).substringToIndex(1)
            if firstLetter.lowercaseString >= "a" && firstLetter.lowercaseString <= "z" {
                keys.append(firstLetter)
            } else {
                keys.append(specialKey)
            }
            temp.append(uniqueSongs[0])
        }
        for var index = 1; index < uniqueSongs.count; index++ {
            if firstLetter == (uniqueSongs[index].title as NSString).substringToIndex(1) {
                temp.append(uniqueSongs[index])
                if (index + 1 < uniqueSongs.count) && (firstLetter != uniqueSongs[index + 1]) {
                    names[firstLetter] = temp
                    temp.removeAll(keepCapacity: false)
                }
            } else {
                firstLetter = (uniqueSongs[index].title as NSString).substringToIndex(1)
                keys.append(firstLetter)
                temp.append(uniqueSongs[index])
            }
        }
    }
*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
//        return keys
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active == true {
            return self.filteredSongs.count
        } else {
            return uniqueSongs.count
        }
    }

//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return keys[section]
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MusicCell = addTableView.dequeueReusableCellWithIdentifier("cell") as! MusicCell
        if self.resultSearchController.active == false {
            cell.theImage.image = uniqueSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
            cell.mainTitle.text = uniqueSongs[indexPath.row].title
            cell.subTitle.text = uniqueSongs[indexPath.row].artist
        } else {
            cell.theImage.image = self.filteredSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
            cell.mainTitle.text = filteredSongs[indexPath.row].title
            cell.subTitle.text = filteredSongs[indexPath.row].artist
        }
        
        return cell
    }
 
// play songs
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if self.resultSearchController.active == true {
//            MPMusicPlayerController().nowPlayingItem = filteredSongs[indexPath.row]
//            MPMusicPlayerController().play()
//        } else {
//            MPMusicPlayerController().nowPlayingItem = uniqueSongs[indexPath.row]
//            MPMusicPlayerController().play()
//        }
//    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredSongs.removeAll(keepCapacity: false)
        
        //let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        var searchText = searchController.searchBar.text!
        
        var titlePredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyTitle, comparisonType: .Contains)
        
        var albumPredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: .Contains)
        
        var artistPredicate: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: searchController.searchBar.text!, forProperty: MPMediaItemPropertyArtist, comparisonType: .Contains)
        
        //var compound = NSCompoundPredicate.andPredicateWithSubpredicates([titlePredicate, albumPredicate])

        
        var query = MPMediaQuery.songsQuery()
        query.addFilterPredicate(titlePredicate)
        filteredSongs = query.items as! [MPMediaItem]
        query = MPMediaQuery.songsQuery()
        query.addFilterPredicate(albumPredicate)
        filteredSongs += query.items as! [MPMediaItem]
        query = MPMediaQuery.songsQuery()
        query.addFilterPredicate(artistPredicate)
        filteredSongs += query.items as! [MPMediaItem]
        
        filteredSongs = Array(Set(filteredSongs))
    
        //filteredSongs = query.items as! [MPMediaItem]
        
            
        //filteredSongs = uniqueSongs
    
        
        self.addTableView.reloadData()
    }
    
    @IBAction func imagePicker(sender: AnyObject) {
        
        var photoPicker = UIImagePickerController()
        photoPicker.setEditing(true, animated: true)
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        coverImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func finishAddList(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Finish Editing", message: "Finished?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func backToJamList(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Back to JamList", message: "Are you sure you want back to JamList without save?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    


}
