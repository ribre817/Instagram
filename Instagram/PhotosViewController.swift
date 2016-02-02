//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Rian Walker on 1/31/16.
//  Copyright © 2016 Rian Walker. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var photos: [NSDictionary]?
    
    @IBOutlet weak var photoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
        photoTableView.rowHeight = 320
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.photos = responseDictionary["data"] as! [NSDictionary]
                            self.photoTableView.reloadData()
                            
                    }
                }
        })
        task.resume()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let photos = photos {
            return photos.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = photoTableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let photo = photos![indexPath.row]
            if let imagePath = photo.valueForKeyPath("images.low_resolution.url") as? String {
                let imageUrl = NSURL(string: imagePath)
                cell.pictureView.setImageWithURL(imageUrl!)
            
        }
        return cell

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
