//
//  PlayersViewController.swift
//  SitOrStartPlus
//
//  Created by Justin Trimachi on 7/5/17.
//  Copyright © 2017 LifeOnTheVine. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var playerPicker: UIPickerView!
    let playerPickerData = ["QB", "RB", "WR", "TE"]
    var jsonURL = "https://api.myjson.com/bins/djifb"
    var selectedIndex = 0
    var QBArray = Array<Dictionary<String,String>>()
    var RBArray = Array<Dictionary<String,String>>()
    var playerStatsArray = [PlayerStats]()
    var playerStats = PlayerStats()
    var name = String()
    var playerImageLink: URL?
    var playerHeight: String?
    var playerWeight: String?
    var playerSalary: String?
    var playerPosition: String?
    var playerTeam: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerPicker.delegate = self
        playerPicker.dataSource = self
        playerPicker.isHidden = true
        getJSONData()
        seedPlayerStatsArray(positionArray: QBArray)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "40YardLine.jpg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ChoosePosition(_ sender: UIButton) {
        playerPicker.backgroundColor = UIColor.white
        playerPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playerPickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedIndex = row
        return playerPickerData[row]
    }

    func getJSONData(){
        
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    
                    let playersParsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    self.QBArray = playersParsedData["QBs"] as! Array<Dictionary<String, String>>
                    
                    print(self.QBArray)
                    
                    self.RBArray = playersParsedData["RBs"] as! Array<Dictionary<String, String>>
                    print(self.RBArray)
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    @IBAction func getPlayerList(_ sender: UIButton) {
        
        if playerPickerData[selectedIndex] == "QB"{
            performSegue(withIdentifier: "Quarterbacks", sender: sender)
        }else if playerPickerData[selectedIndex] == "RB"{
           performSegue(withIdentifier: "RunningBacks", sender: sender)
        }
        
        playerPicker.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qbVC = segue.destination as? QBViewController{
            qbVC.QBArray = self.QBArray
            DispatchQueue.main.async {
                self.seedPlayerStatsArray(positionArray: self.QBArray)
                qbVC.playerStatsArray = self.playerStatsArray
            }
            
        }
        
        if let rbVC = segue.destination as? RBViewController{
            rbVC.RBArray = self.RBArray
            seedPlayerStatsArray(positionArray: RBArray)
            rbVC.playerStatsArray = playerStatsArray
        }
    }
    
    func seedPlayerStatsArray(positionArray: Array<Dictionary<String, String>>){
        for playerDict in positionArray{
            self.name = playerDict["name"]!
            self.playerPosition = playerDict["position"]!
            self.playerImageLink = URL(string: playerDict["image"]!)
            self.playerTeam = playerDict["team"]!
            self.playerHeight = playerDict["height"]!
            self.playerWeight = playerDict["weight"]!
            self.playerSalary = playerDict["salary"]
            self.playerStats = PlayerStats(name: self.name, playerImageLink: self.playerImageLink!, playerHeight: self.playerHeight!, playerWeight: self.playerWeight!, playerTeam: self.playerTeam!, playerSalary: self.playerSalary!, playerPosition: self.playerPosition!)
            self.playerStatsArray.append(self.playerStats)
        }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { playerStatsArray.removeAll()}
}

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}
