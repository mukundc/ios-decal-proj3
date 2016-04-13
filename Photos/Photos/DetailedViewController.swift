//
//  DetailedViewController.swift
//  Photos
//
//  Created by Mukund Chillakanti on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var heart: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var photoInfo: [String : Any]!
    var photo: Photo!
    var count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        let i = UIImage(data:photoInfo["data"] as! NSData)
        image.image = scaleUIImageToSize(i!, size: CGSize(width: 200, height: 200))

        self.count = photoInfo["likes"] as! Int
        self.likes.text = "Likes: " + String(self.count)
        self.username.text = "User: " + (photoInfo["username"] as! String)
        let actualDate = NSDate(timeIntervalSince1970 : Double(photoInfo["date"] as! String)!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let convertedDate = dateFormatter.stringFromDate(actualDate)
        self.datePosted.text = "Date Posted: " + convertedDate
        self.photo = photoInfo["photo"] as! Photo
        self.heart.titleLabel!.font =  UIFont(name: "Arial-MT", size: 70)

        if (photo.isLiked == false) {
            self.heart.setTitle("♡", forState: .Normal)
        }
        else {
            self.heart.setTitle("❤", forState: .Normal)
        }
    }
    @IBAction func pressedHeart(sender: AnyObject) {
        if self.photo.isLiked == true {
            self.photo.isLiked  = false
        } else  {
            self.photo.isLiked  = true
        }
        
        print(self.photo.isLiked)
        
        if (self.photo.isLiked == false) {
            self.heart.setTitle("♡", forState: .Normal)
            self.count = self.count - 1
        }
        else {
            self.heart.setTitle("❤", forState: .Normal)
            self.count = self.count + 1
        }
        self.likes.text = "Likes: " + String(self.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
