//
//  MemeTableViewController.swift
//  meme
//
//  Created by andrew on 31/05/2015.
//  Copyright (c) 2015 Firekite. All rights reserved.
//

import UIKit




class MemeTableViewController:  UITableViewController,
                                UITableViewDataSource ,
                                UITableViewDelegate
{

    
    var memes: [MemeModel]!
    //var meme: MemeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        // this is required so that the view controller and see the memes array
        
        
      //  self.tableView.registerNib(UINib(nibName: "memeTableCell", bundle: nil), forCellReuseIdentifier: "memeTableCell") // need ed toreset this now works!a
        
        

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        println("TableWill  \(memes.count)")
        //test to make sure array is working
        for meme in memes {
        println("Table will appear count \(meme.topText)")
        }
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        println("Table \(self.memes.count)")
        //println("TableRowsInsection \(self.meme.topText)")
        return memes.count
        
    }
 
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        // let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell", forIndexPath: indexPath) as! MemeTableCell
        
        
        let meme = self.memes[indexPath.row]
        cell.memeTitle.text  = "\(meme.topText), \(meme.bottomText)"
        cell.memedImage.image = meme.memedImage
        
        
        //cell.detailTextLabel?.text = meme.bottomText
        //let imageView = UIImageView(image: meme.origanalImage)
        //cell.backgroundView = imageView
        
        println("This should be the first item  \(self.memes[0])")
        println("This should be the first item  \(self.memes[indexPath.row])")

        return cell
    
    }
    
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
            
            //Grab the DetailVC from Storyboard
            let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("AddVC")!
            
            let detailVC = object as! ViewController
            //Populate view controller with data from the selected item
            detailVC.meme  = self.memes[indexPath.row]
            
            //Present the view controller using navigation
            self.navigationController!.pushViewController(detailVC, animated: true)
    }
  
    
    

}
