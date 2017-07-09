//
//  ImageDownload.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/9/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import Foundation
import UIKit

class ImageDownload{

    var image: UIImage?
    var playerImage: UIImage?
    var imagesDictionary = [String:UIImage]()
    
    private init() { }
    
    // MARK: Shared Instance
    
    static let sharedImageDownload = ImageDownload()
    
    func getPlayerImage() -> UIImage{
        return self.image!
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }

    func downloadImage(url: URL, name: String){
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(data: data)
                self.imagesDictionary[name] = self.image
            }
        }
    }
    
}
