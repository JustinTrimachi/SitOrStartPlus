//
//  QBViewController.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/5/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import UIKit

class QBViewController: UIViewController {
    
    @IBOutlet weak var qbTableView: UITableView!
    var QBArray = Array<Dictionary<String,String>>()
    var playerStatsArray = [PlayerStats]()
    var currentQB = PlayerStats()
    var currentIndexPath = Int()
    var qbName = String()
    var qbSalary = String()
    var qbHeight = String()
    var qbWeight = String()
    var qbImageLink: URL?
    var qbTeam = String()
    var QB: PlayerStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qbTableView.delegate = self
        qbTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }


extension QBViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPath = indexPath.row
    }
}

extension QBViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QBArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = qbTableView.dequeueReusableCell(withIdentifier: "QBCell", for: indexPath) as! QBCell
        let qbDictionary = QBArray[indexPath.row]
        cell.qbName.text = qbDictionary["name"]
        let url = URL(string: qbDictionary["image"]!)
        DispatchQueue.main.async() { () -> Void in
            self.downloadQBImage(urlString: url, name: qbDictionary["name"]!)
        }
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerDetailVC = segue.destination as? PlayerDetailViewController{
            let playerIndex = qbTableView.indexPathForSelectedRow?.row
            currentQB = playerStatsArray[playerIndex!]
            playerDetailVC.tempPlayerPosition = currentQB.playerPosition!
            playerDetailVC.tempPlayerName = currentQB.name!
            playerDetailVC.tempPlayerTeam = currentQB.playerTeam!
            playerDetailVC.tempPlayerHeight = currentQB.playerHeight!
            playerDetailVC.tempPlayerWeight = currentQB.playerWeight!
            playerDetailVC.tempPlayerSalary = currentQB.playerSalary!
        }
    }
    
    func downloadQBImage(urlString: URL?, name: String){
        if let imageUrl = urlString{
            ImageDownload.sharedImageDownload.downloadImage(url: imageUrl, name: name)
        }
    }
    
    @IBAction func unwindToQBVC(segue:UIStoryboardSegue) { playerStatsArray.removeAll()}
    
}
