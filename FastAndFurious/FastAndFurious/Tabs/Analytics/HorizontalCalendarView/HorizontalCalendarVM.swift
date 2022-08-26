//
//  HorizontalCalendarVM.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import Foundation

class HorizontalCalendarVM {

    var events = [Event]()

    var selectedEvent: Event!

    private var selectedDate: Date

    init(selectedDate: Date = Date()) {
        self.selectedDate = selectedDate
        self.events = getEvents()
    }

    func updateEvents(for currentSelectedIndex: Int) -> Bool {
        guard let lastSelectedIndex = events.firstIndex(where: { $0.isSelected }) else {
            return false
        }

        var event = events[lastSelectedIndex]
        event.isSelected = false
        events.remove(at: lastSelectedIndex)
        events.insert(event, at: lastSelectedIndex)

        var nextEvent = events[currentSelectedIndex]
        nextEvent.isSelected = true
        events.remove(at: currentSelectedIndex)
        events.insert(nextEvent, at: currentSelectedIndex)

        return true
    }

    private func getEvents() -> [Event] {
        var today = selectedDate
        var events = [Event]()

        let currentEvent = Event(isSelected: true,
                                 date: today)

        selectedEvent = currentEvent
        events.append(currentEvent)

        for _ in 1...30 {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
            today = tomorrow

            let event = Event(isSelected: false,
                              date: today)

            events.append(event)
        }

        return events
    }
}
