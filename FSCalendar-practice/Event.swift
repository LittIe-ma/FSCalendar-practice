//
//  Event.swift
//  FSCalendar-practice
//
//  Created by yasudamasato on 2021/11/03.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
}
