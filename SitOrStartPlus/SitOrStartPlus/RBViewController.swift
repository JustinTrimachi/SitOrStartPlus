//
//  RBViewController.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/5/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import UIKit

class RBViewController: UIViewController {

    @IBOutlet weak var rbTableView: UITableView!
    var RBArray = Array<Dictionary<String,String>>()
    var playerStatsArray = [PlayerStats]()
    var currentRB = PlayerStats()

    override func viewDidLoad() {
        super.viewDidLoad()
        rbTableView.dataSource = self
        rbTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RBViewController: UITableViewDelegate{
    
}

extension RBViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RBArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rbTableView.dequeueReusableCell(withIdentifier: "RBCell", for: indexPath) as! RBCell
        
        let rbDictionary = RBArray[indexPath.row]
        cell.rbName.text = rbDictionary["name"]
        let url = URL(string: rbDictionary["image"]!)
        DispatchQueue.main.async() { () -> Void in
            self.downloadQBImage(urlString: url, name: rbDictionary["name"]!)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerDetailVC = segue.destination as? PlayerDetailViewController{
            let playerIndex = rbTableView.indexPathForSelectedRow?.row
            currentRB = playerStatsArray[playerIndex!]
            playerDetailVC.tempPlayerPosition = currentRB.playerPosition!
            playerDetailVC.tempPlayerName = currentRB.name!
            playerDetailVC.tempPlayerTeam = currentRB.playerTeam!
            playerDetailVC.tempPlayerHeight = currentRB.playerHeight!
            playerDetailVC.tempPlayerWeight = currentRB.playerWeight!
            playerDetailVC.tempPlayerSalary = currentRB.playerSalary!
        }
    }
    
    func downloadQBImage(urlString: URL?, name: String){
        if let imageUrl = urlString{
            ImageDownload.sharedImageDownload.downloadImage(url: imageUrl, name: name)
        }
    }


}
