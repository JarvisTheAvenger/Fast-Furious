//
//  DateHelper.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import Foundation

extension Date {

    func get(_ component: Calendar.Component,
             calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }

}


