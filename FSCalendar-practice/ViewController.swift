//
//  ViewController.swift
//  FSCalendar-practice
//
//  Created by yasudamasato on 2021/11/02.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet private weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.todayColor = .red
        calendar.appearance.headerTitleColor = .red
        calendar.appearance.weekdayTextColor = .red
    }


}

