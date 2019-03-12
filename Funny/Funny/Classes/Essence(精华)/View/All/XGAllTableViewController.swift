//
//  XGAllTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGAllTableViewController: XGTopicTableViewController
{
    override var topicType: XGTopicType {
        return .Word
    }
    
    override var reuseIdentifier: String {
        return NSStringFromClass(XGAllTableViewController.self)
    }
    
    override func registerTableCell() {
        tableView.register(XGAllTopicTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
