//
//  addNewListViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/17/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

class addNewListViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate {
    
    var uniqueSongs :[MPMediaItem]!
    
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var imagePicker: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coverImage.layer.borderWidth = 1
        var songCollection = MPMediaQuery.songsQuery()
        uniqueSongs = (songCollection.items as! [MPMediaItem]).filter({song in song.playbackDuration > 30 })
        addTableView.allowsMultipleSelection = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MusicCell = addTableView.dequeueReusableCellWithIdentifier("cell") as! MusicCell
        cell.theImage.image = uniqueSongs[indexPath.row].artwork.imageWithSize(CGSize(width: 54, height: 54))
        cell.mainTitle.text = uniqueSongs[indexPath.row].title
        cell.subTitle.text = uniqueSongs[indexPath.row].artist

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueSongs.count
    }

    @IBAction func imagePicker(sender: AnyObject) {
        
        var photoPicker = UIImagePickerController()
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
