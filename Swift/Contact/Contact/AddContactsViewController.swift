//
//  AddContactsViewController.swift
//  Contact
//
//  Created by 刘欢 on 2017/5/13.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class AddContactsViewController: UITableViewController {

    var contactsIndexTitles: ContactsIndexTitles = ([String](), [String: [PersonPhoneModel]]())
    
    var indexTitles: [String] {
        get {
            return contactsIndexTitles.0
        }
    }
    
    var contactsList: [String: [PersonPhoneModel]] {
        get {
            return contactsIndexTitles.1
        }
    }
    
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加手机联系人"
        AuthorizationManager.config { (config) in
            config.title = "通讯录授权"
            config.message = "通讯录授权"
            config.presentingViewController = self
            }.authorizedContacts { (result) in
                switch result {
                case .success(let str):
                    print(str)
                    DispatchQueue.global().async {
                        let list = ContactsManager.getContactsList()
                        self.contactsIndexTitles = ContactsManager.format(contantsList: list)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let e):
                    print(e.description)
                }
        }
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        self.navigationItem.rightBarButtonItem=self.editButtonItem
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if !editing {
            if let indexPath = self.tableView.indexPathsForSelectedRows  {
                // 处理选中的东西
                print(indexPath)
            }
        }
        super.setEditing(editing, animated: animated)
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactsList.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let arr = contactsList[indexTitles[section]] else {
            return 0;
        }
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        guard let arr = contactsList[indexTitles[indexPath.section]] else {
            return cell!;
        }
        let personPhoneModel = arr[indexPath.row]
        
        cell?.textLabel?.text = personPhoneModel.fullName
        cell?.detailTextLabel?.text = personPhoneModel.phoneNumber
        cell?.imageView?.image = UIImage(named: "timg.jpeg")
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}
