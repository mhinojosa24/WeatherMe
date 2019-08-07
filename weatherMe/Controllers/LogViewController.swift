//
//  LogViewController.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//

import UIKit
import RealmSwift

class LogViewController: UITableViewController {
    
    var moods: Results<Mood>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "Log"
        let nib = UINib(nibName: "MoodCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "moodCell")
        self.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moods != nil {
            return moods.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath) as! MoodCell
        let mood = moods[indexPath.row]
        cell.moodImg.text = mood.img
        cell.moodTitle.text = mood.mood
//        cell.dateTitle.text = mood.date
        
        return cell
    }
    
    func reloadData() {
        moods = uiRealm.objects(Mood.self)
        self.tableView.reloadData()
    }
    
}
