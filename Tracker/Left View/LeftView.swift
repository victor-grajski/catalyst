//
//  LeftView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class LeftView : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var entryTableView: UITableView!
    var feedEntries: [Entry]!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LeftView.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    @IBAction func iCloudRestore(_ sender: UIButton) {
        let iCloudKeyStoreRestore: NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore()
        var entriesRestoreArray: [Entry] = []
        if let entriesArray = iCloudKeyStoreRestore?.array(forKey: "entries") as? [[String]] {
            for entry in entriesArray {
                entriesRestoreArray.append(parseStringList(stringList: entry))
            }
            UserDefaults.standard.set(entriesRestoreArray.map {$0.toStringList()}, forKey: "entries" )
            
            if let countsRestore = iCloudKeyStoreRestore?.dictionary(forKey: "counts") as? [String:Int] {
                UserDefaults.standard.set(countsRestore, forKey: "counts")
            }
            
            let alert = UIAlertController ( title : "iCloud Restore" , message : "Your iCloud entries have been restored." , preferredStyle : . alert )
            alert . addAction ( UIAlertAction ( title : "Refresh" , style : UIAlertAction . Style . default, handler: { action in self.handleRefresh(self.refreshControl)}))
            self . present ( alert , animated : true , completion : nil )
        }
    }
    
    override func viewDidLoad ( ) {
        super . viewDidLoad ( )

        self.entryTableView.backgroundColor = UIColor . black
        self.entryTableView.layer.cornerRadius = 10
        entryTableView.delegate = self
        entryTableView.dataSource = self
        
        let nib = UINib.init(nibName: "EntryTableViewCell", bundle: nil)
        entryTableView.register(nib, forCellReuseIdentifier: "EntryTableViewCell")
        
        self.entryTableView.addSubview(self.refreshControl)
        self.loadFromUserDefaults()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.loadFromUserDefaults()
        self.entryTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadFromUserDefaults() {
        feedEntries = []
        
        if (UserDefaults . standard . array ( forKey : "entries" ) as? [ [ String ] ]) != nil {
            
            for entryStringList in ( UserDefaults . standard . array ( forKey : "entries" ) as? [ [ String ] ] )! {
                feedEntries . append ( parseStringList ( stringList : entryStringList ) )
            }
            
        }
    }
    
    func parseStringList ( stringList : [ String ] ) -> Entry {
        
        return Entry (
            text1 : stringList [ 0 ] ,
            traps : stringToIntList ( string : stringList [ 1 ] ) ,
            text2 : stringList [ 2 ] ,
            dateString : stringList [ 3 ]
        )
        
    }
    
    func stringToIntList ( string : String ) -> [ Int ] {
        
        return string . components ( separatedBy : " " ) . map { Int ( $0 )! }
        
    }
    


    // MARK: - UITableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedEntries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath) as! EntryTableViewCell
        
        cell.testLabel.text = feedEntries[indexPath.item].getTimeElapsedString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryDetail = EntryDetailViewController()
        
        entryDescription = feedEntries[indexPath.item].text1
        entryReframe = feedEntries[indexPath.item].text2
        entryThoughtTrapArray = feedEntries[indexPath.item].traps

        self.present(entryDetail, animated: true, completion: nil)
    }

}
