//
//  MemeCollectionViewController.swift
//  meme
//
//  Created by andrew on 31/05/2015.
//  Copyright (c) 2015 Firekite. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegate
{

    
    var memes: [MemeModel]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes        
        
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
/*
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }
*/

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("Collection count\(memes.count)")
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionCell
  

        let meme = self.memes[indexPath.item]
        cell.memedImage.image = meme.memedImage
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText

        
        println("This should be the first item  \(self.memes[0])")
        println("This should be the first item  \(self.memes[indexPath.row])")

        
        /*
        cell.setText(meme.top, bottomString: meme.bottom)
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        */
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
