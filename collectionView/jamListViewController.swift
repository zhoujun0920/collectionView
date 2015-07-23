//
//  ViewController.swift
//  collectionView
//
//  Created by Jun Zhou on 7/15/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import MediaPlayer

struct GlobalList {
    static var collectionArray: [String] = [String]()
    static var imageArray: [UIImage] = [UIImage]()
    static var numberArray: [String] = [String]()
    static var newList: [MPMediaItem] = [MPMediaItem]()
    static var listTotal: [jamList] = [jamList]()
}



class jamListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //var secondViewController = (segue.destinationViewController.visibleViewController as addNewListViewController)
    
    //secondViewController.delegate = self
    
    var addButton: UIButton = UIButton()
    
    var startPointX: Int = Int()
    var startPointY: Int = Int()
    
    var Songs: [Song] = [Song]()



    
    var selectedImage: UIImageView = UIImageView()
    
    let transition = PopAnimator()
    
    @IBOutlet weak var jamListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GlobalList.collectionArray = ["Favorite", "Recent Played", "Most Played", "New Playlist"]
        GlobalList.imageArray = [UIImage(named: "jay.jpg")!, UIImage(named: "jay2.jpg")!, UIImage(named: "jay4.jpeg")!, UIImage(named: "jay5.jpg")!]
        GlobalList.numberArray = ["no", "no", "no", ""]
        
        var favoriteSong: jamList = jamList()
        favoriteSong.listname = "Favorite"
        GlobalList.listTotal.append(favoriteSong)
        var recentplayed: jamList = jamList()
        recentplayed.listname = "Recent Played"
        GlobalList.listTotal.append(recentplayed)
        var recentadded: jamList = jamList()
        recentadded.listname = "Most Played"
        GlobalList.listTotal.append(recentadded)
        
        var listNumber = GlobalList.listTotal.count
        

    }
    
    override func viewDidAppear(animated: Bool) {
        jamListCollectionView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalList.collectionArray.count
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
        name.text = GlobalList.collectionArray[indexPath.row]
        name.textColor = UIColor.redColor()
        if indexPath.row != GlobalList.collectionArray.count - 1 {
            number.text = GlobalList.numberArray[indexPath.row] + " songs"
            number.textColor = UIColor.blueColor()
            name.textColor = UIColor.redColor()
        } else {
            name.numberOfLines = 2;
            name.lineBreakMode = NSLineBreakMode.ByWordWrapping
            number.alpha = 0
        }
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = GlobalList.imageArray[indexPath.row]

        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        //        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: nil, animations: ({
        //            cell?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //        }), completion: nil)
        if indexPath.row != GlobalList.collectionArray.count - 1 {
            let songListView = storyboard!.instantiateViewControllerWithIdentifier("songList") as! songListViewController
            println(indexPath.row)
            songListView.songs = GlobalList.listTotal[indexPath.row]
        
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