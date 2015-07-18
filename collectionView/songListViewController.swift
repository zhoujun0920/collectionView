//
//  secondViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/15/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit

class songListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectListNumber: Int = Int()
    var songs: jamList = jamList()
    var songNumber: Int = Int()
    //var songName: String = String()
    
    @IBOutlet weak var listName: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!

    
    override func viewDidLoad() {
        listName.text = songs.listname
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.listTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = songs.listContent[indexPath.row].name
        
        
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
