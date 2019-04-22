//
//  DetailViewController.swift
//  Flix
//
//  Created by user145843 on 4/16/19.
//  Copyright © 2019 T3Tech. All rights reserved.
//

import UIKit
import AlamofireImage
class DetailViewController: UIViewController {

    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var apiDic = [String:Any]()
    let base = "https://image.tmdb.org/t/p/w500"
    override func viewDidLoad() {
        super.viewDidLoad()
        print(apiDic)
        let poster = apiDic["poster_path"] as! String
        let background = apiDic["backdrop_path"] as! String
        let posterURL = base + poster
        let backgroundURL = base + background
        let posterAdress = URL(string: posterURL)
        let backgroundAdress = URL(string: backgroundURL)
        //print(url)
        self.posterView.af_setImage(withURL: posterAdress!)
        self.backView.af_setImage(withURL: backgroundAdress!)
        self.dateLabel.text = (apiDic["release_date"] as! String)
        self.descriptionLabel.text = (apiDic["overview"] as! String)
        self.titleLabel.text = (apiDic["title"] as! String)
        //self.posterView.image?.af_inflate()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
