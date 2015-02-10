//
//  DeliveryNonChickenViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 11..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class DeliveryNonChickenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var storeList = Array<StoreModel>()
    
    @IBOutlet weak var storeListTableView: UITableView!
    
    override func viewDidLoad() {
        storeListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        storeListTableView.dataSource = self
        storeListTableView.delegate = self
        
        storeListTableView.rowHeight = 50
        
        // Init Store info
        let allList = StoreListModel.sharedInstance.storeList
        
        for item in allList {
            if item.category == "nonChic" {
                self.storeList.append(item)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = self.storeListTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell
        }
        
        // remove previous labels
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        // make cell content
        let tableWidth = tableView.frame.width
        let labelWidth = (tableWidth-60)
        
        // name Text Label
        let nameLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: labelWidth, height: 30.0))
        nameLabel.text = self.storeList[indexPath.row].name
        nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        nameLabel.textAlignment = NSTextAlignment.Left
        cell.addSubview(nameLabel)
        
        let phoneLabel = UILabel(frame: CGRect(x: 0, y: 30.0, width: labelWidth/2, height: 10.0))
        phoneLabel.text = self.storeList[indexPath.row].phone
        phoneLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        phoneLabel.textAlignment = NSTextAlignment.Left
        phoneLabel.font = UIFont(name: phoneLabel.font.fontName, size: 11)
        cell.addSubview(phoneLabel)
        
        let rtLabel = UILabel(frame: CGRect(x: labelWidth/2, y: 30.0, width: labelWidth/2, height: 10.0))
        rtLabel.text = self.storeList[indexPath.row].runTime
        rtLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        rtLabel.textAlignment = NSTextAlignment.Right
        rtLabel.font = UIFont(name: rtLabel.font.fontName, size: 11)
        cell.addSubview(rtLabel)
        
        let phoneButton = UIButton(frame: CGRect(x: labelWidth + 10, y: 5, width: 40, height: 40))
        phoneButton.setImage(UIImage(named: "phone_icon.png"), forState: .Normal)
        phoneButton.tag = indexPath.row
        phoneButton.addTarget(self, action: "callButtonPushed:", forControlEvents: .TouchUpInside)
        cell.addSubview(phoneButton)
        
        cell.separatorInset.bottom = 1.0
        return cell
    }
    
    // call Button event handler
    func callButtonPushed(sender: UIButton!) {
        let url = NSURL(string: self.storeList[sender.tag].phone)
        UIApplication.sharedApplication().openURL(url!)
    }
}