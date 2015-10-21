//
//  DateViewController.swift
//  Homepwner
//
//  Created by Matthew Compton on 10/21/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit


class DateViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
    
}
