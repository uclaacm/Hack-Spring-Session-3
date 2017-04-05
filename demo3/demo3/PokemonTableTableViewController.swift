//
//  PokemonTableTableViewController.swift
//  demo3
//
//  Created by Shannon Phu on 4/2/17.
//  Copyright © 2017 Shannon Phu. All rights reserved.
//

// JSON Source: https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json

import UIKit

class PokemonTableTableViewController: UITableViewController {
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let json = getJSON()
        self.pokemons = convertJSONToPokemon(data: json)
        
        for p in self.pokemons {
            print("\(p.name) \(p.imageURL) \(p.type) \(p.weight)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJSON() -> [Any] {
        if let filePath = Bundle.main.path(forResource:"pokedex", ofType:"json") {
            if let data = NSData(contentsOfFile: filePath) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String:Any]
                    return json["pokemon"] as! [Any]
                } catch let error as NSError {
                    print("Error occured while loading json file")
                    print(error.description)
                    return []
                }
            }
        }
        return []
    }
    
    func convertJSONToPokemon(data: [Any]) -> [Pokemon] {
        var pokemons: [Pokemon] = []
        
        for p in data {
            var obj = p as! Dictionary<String, Any>
            print(p)
            let name = obj["name"] as! String
            let url = obj["img"] as! String
            
            var types = obj["type"] as! [String]
            let primaryType = types[0]
            
            let weight = obj["weight"] as! String
            
            let pokemon = Pokemon(name: name, imageURL: url, type: primaryType, weight: weight)
            pokemons.append(pokemon)
        }
        
        return pokemons
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = self.pokemons[indexPath.row].name
        cell.detailTextLabel?.text = self.pokemons[indexPath.row].type
        let imgURL = self.pokemons[indexPath.row].imageURL
        
        // This placeholder image added later on to allow for smoother loading of actual image
        cell.imageView?.image = UIImage(named: "pokeball.png")

        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .background).async {
            do {
                // Error appears after adding this (given solution is a workaround)
                // App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.
                // Solution: http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http
                let imgData = try Data(contentsOf: imgURL)
                
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: imgData)
                }
            } catch {
                print("Could not download image URL.")
            }
        }
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
