//
//  ViewController.swift
//  meme
//
//  Created by andrew on 25/05/2015.
//  Copyright (c) 2015 Firekite. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraImageActionOutlet: UIBarButtonItem!
    @IBOutlet weak var shareMemeOutlet: UIButton!
    @IBOutlet weak var topFieldOutlet: UITextField!
    @IBOutlet weak var bottomFieldOutlet: UITextField!
    
    
    var memedImage: UIImage!
    var meme: MemeModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Verdana", size: 20)!,
            NSStrokeWidthAttributeName : 5.0
        ]
        
        topFieldOutlet.delegate = self
        bottomFieldOutlet.delegate = self
        // set delegate of both textFields
        topFieldOutlet.textAlignment = .Center
        topFieldOutlet.defaultTextAttributes = memeTextAttributes
        
        bottomFieldOutlet.textAlignment = .Center
        bottomFieldOutlet.defaultTextAttributes = memeTextAttributes

        //shareMemeOutlet.userInteractionEnabled = true // reenable the share button
        self.subscribeToKeyboardNotifications()
        shareMemeOutlet.userInteractionEnabled = false
        shareMemeOutlet.hidden = true
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.subscribeToKeyboardNotifications() // not sure why I need this as it works without?
        topFieldOutlet.textAlignment = .Center
        bottomFieldOutlet.textAlignment = .Center
        cameraImageActionOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //self.unsubscribeFromKeyboardNotifications()  // not sure how I can get this to work?
        println("ViewWillDissappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)


    }
    
    
    
  
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        println("resign")
        return true

    }
    
    func textFieldDidBeginEditing(textField: UITextField) {

    }
    
    
    @IBAction func pickImageAction(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // need to sepcify where the image is coming from album or camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraImageAction(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
  
    
    // two  following methods are reqiured by the imagePickerController
    //need to implement these methods in order to get access to an image chosen from the Photo library or camera
    
    // this manages the image picker interface
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imagePickerView.image = image
                imagePickerView.contentMode = .ScaleAspectFill // maintains aspect ratio
                
            }
            // This method allows the UIIMage access to the image from the list
            self.dismissViewControllerAnimated(true, completion: nil)
            shareMemeOutlet.userInteractionEnabled = true // reenable the share button
            shareMemeOutlet.hidden = false
            
    }
    
    // allow to dismiss the picker view by calling dismissViewController ..
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        shareMemeOutlet.userInteractionEnabled = false // disables the share button
        shareMemeOutlet.hidden = true
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
         // the selector is the methods called following the keyboard notifications
        println("subscribe")
    }

    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification,  object: nil)
        println("unsubscribe")
    }

    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    
    func keyboardWillShow(notification: NSNotification) {
        if bottomFieldOutlet.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            println("Show  \(self.view.frame.origin.y)")
        } else if topFieldOutlet.isFirstResponder() {
    }
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomFieldOutlet.isFirstResponder() {
            self.view.frame.origin.y  += getKeyboardHeight(notification)
            println("Hide  \(self.view.frame.origin.y)")
        }
    }
    
    
    func save() {
        //Create the meme as a tuple
        var meme = MemeModel(
            topText: topFieldOutlet.text!,
            bottomText: bottomFieldOutlet.text!,
            origanalImage: imagePickerView.image!,
            memedImage: generateMemedImage()
            )
        // add meme to array
        println("save")


        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    
    func generateMemedImage() -> UIImage
    {
        // TODO: Hide toolbar and navbar
        //self.navigationController?.setToolbarHidden(true, animated: animated)
        self.navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //ToDo: Show toolbar and NavBar
        //self.navigationController?.setToolbarHidden()
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        
        return memedImage
    }
    
    
    @IBAction func shareMemeAction(sender: AnyObject) {
        var thisImage = generateMemedImage()
        let controller =  UIActivityViewController(activityItems: [thisImage], applicationActivities: nil)
        self.presentViewController(controller,animated:true, completion:nil)
        controller.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            println("completed \(s) \(ok) \(items) \(err)")
            
        self.dismissViewControllerAnimated(false, completion: nil)
        }
        save()
        
    }
}