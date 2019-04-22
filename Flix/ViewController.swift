//
//  ViewController.swift
//  Flix
//
//  Created by user145843 on 4/10/19.
//  Copyright © 2019 T3Tech. All rights reserved.
//

import UIKit
import AlamofireImage
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var apiDic = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.apiDic = dataDictionary["results"] as! [[String:Any]]
                //print(self.apiDic)
                self.tableView.reloadData()
                
            }
            
        }
        task.resume()
        
        }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return apiDic.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell
        
            cell!.titleLabel.text = apiDic[indexPath.row]["original_title"] as? String
        
        cell?.desLabel.text = apiDic[indexPath.row]["overview"] as? String
        let base = "https://image.tmdb.org/t/p/w154"
        let ext = apiDic[indexPath.row]["poster_path"] as! String
        let string  = (base+ext)
        let url = URL(string: string)
        //print("here",url)
        cell?.imageView?.af_setImage(withURL: url!)
        cell?.setSelected(true, animated: true)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieCell
        performSegue(withIdentifier: "goToDetail", sender: cell)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DetailVC = segue.destination as! DetailViewController
        //print(DetailVC)
        let cell = sender as! MovieCell
        //print(cell)
        let indexPath = tableView.indexPath(for: cell)!.row
        DetailVC.apiDic = apiDic[indexPath]
        
    }

}


