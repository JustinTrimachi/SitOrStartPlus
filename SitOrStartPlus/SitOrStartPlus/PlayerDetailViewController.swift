//
//  PlayerDetailViewController.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/5/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerTeam: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerHeight: UILabel!
    @IBOutlet weak var playerWeight: UILabel!
    @IBOutlet weak var playerSalary: UILabel!
    
    var tempPlayerImageLink: URL?
    var tempPlayerName = String()
    var tempPlayerTeam = String()
    var tempPlayerPosition = String()
    var tempPlayerHeight = String()
    var tempPlayerWeight = String()
    var tempPlayerSalary = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sleep(3)
        playerSalary.text = "Current Salary:\(tempPlayerSalary)"
        playerWeight.text = "Weight: \(tempPlayerWeight)"
        playerHeight.text = "Height: \(tempPlayerHeight)"
        playerTeam.text = "Team: \(tempPlayerTeam)"
        playerName.text = tempPlayerName
        playerPosition.text = "Position: \(tempPlayerPosition)"
        playerImage.image = ImageDownload.sharedImageDownload.imagesDictionary[tempPlayerName]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
