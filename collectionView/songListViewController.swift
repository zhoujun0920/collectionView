//
//  secondViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/15/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

class songListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var uniqueSongs :[MPMediaItem] = [MPMediaItem]()
    var selectListNumber: Int = Int()
    var songs: jamList = jamList()
    var songNumber: Int = Int()
    
    @IBOutlet weak var listName: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!

    
    override func viewDidLoad() {
        listName.text = songs.listname
        var songCollection = MPMediaQuery.songsQuery()
        uniqueSongs = songCollection.items as! [MPMediaItem]
        
        uniqueSongs = uniqueSongs.sorted{ $0.title < $1.title }
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.listTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
                
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.listContent.count
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // handle delete (by removing the data from your array and updating the tableview)

        }
    }
    

    @IBAction func backToJamList(sender: AnyObject) {
//        var jamListView = storyboard?.instantiateViewControllerWithIdentifier("jamList") as! jamListViewController
        //jamListView.numberArray[selectListNumber] = "\(selectListNumber)"
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
