//
//  ViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/15/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

class jamListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var addButton: UIButton = UIButton()
    
    var startPointX: Int = Int()
    var startPointY: Int = Int()
    
    var Songs: [Song] = [Song]()
    var collectionArray = ["Favorite", "Recent Played", "Most Played", "New Playlist"]
    var imageArray = [UIImage(named: "jay.jpg"), UIImage(named: "jay2.jpg"), UIImage(named: "jay4.jpeg"), UIImage(named: "jay5.jpg")]
    var numberArray = ["no", "no", "no", ""]
    var listTotal: [jamList] = [jamList]()
    var newList: [MPMediaItem] = [MPMediaItem]()
    
    var selectedImage: UIImageView = UIImageView()
    
    let transition = PopAnimator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var favoriteSong: jamList = jamList()
        favoriteSong.listname = "Favorite"
        listTotal.append(favoriteSong)
        var recentplayed: jamList = jamList()
        recentplayed.listname = "Recent Played"
        listTotal.append(recentplayed)
        var recentadded: jamList = jamList()
        recentadded.listname = "Most Played"
        listTotal.append(recentadded)
        
        var listNumber = listTotal.count
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        
        var number = cell.viewWithTag(3) as! UILabel
        var name = cell.viewWithTag(2) as! UILabel
        name.text = collectionArray[indexPath.row]
        name.textColor = UIColor.redColor()
        if indexPath.row != collectionArray.count - 1 {
            number.text = numberArray[indexPath.row] + " songs"
            number.textColor = UIColor.blueColor()
            name.textColor = UIColor.redColor()
        } else {
            name.numberOfLines = 2;
            name.lineBreakMode = NSLineBreakMode.ByWordWrapping
            number.alpha = 0
        }
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]

        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        //        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: nil, animations: ({
        //            cell?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //        }), completion: nil)
        if indexPath.row != collectionArray.count - 1 {
            let songListView = storyboard!.instantiateViewControllerWithIdentifier("songList") as! songListViewController
            println(indexPath.row)
            songListView.songs = listTotal[indexPath.row]
        
            songListView.selectListNumber = indexPath.row
            //songListView.selectListName = collectionArray[indexPath.row]
            selectedImage = cell?.viewWithTag(1) as! UIImageView
        
            songListView.transitioningDelegate = self
            self.presentViewController(songListView, animated: true, completion: nil)
        } else {
            let addListView = storyboard!.instantiateViewControllerWithIdentifier("addList") as! addNewListViewController
            println(indexPath.row)
            addListView.transitioningDelegate = self
            self.selectedImage = cell?.viewWithTag(1) as! UIImageView
            self.presentViewController(addListView, animated: true, completion: nil)
        }
        
        
    }
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//
//        
//    }
}

extension jamListViewController: UIViewControllerTransitioningDelegate{
    
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            transition.originFrame = selectedImage.convertRect(selectedImage.frame, toView: nil)
            
            transition.presenting = true
            
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}