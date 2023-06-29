import SwiftUI
import WidgetKit
import AppIntents

     struct DateConfiguration: WidgetConfigurationIntent {
         static var title: LocalizedStringResource = "Character"
     }

struct DateDetailProvider: AppIntentTimelineProvider {

  struct DateEntry: TimelineEntry {
    let date: Date
    let configuration: DateConfiguration
  }

  func placeholder(in context: Context) -> DateEntry {
    DateEntry(date: .now, configuration: .init())
  }
  
  func timeline(for configuration: DateConfiguration, in context: Context) async -> Timeline<DateEntry> {
    var entries: [DateEntry] = []
    let currentDate: Date = .now

    for minuteOffset in 0 ..< 60 {
      let entryDate = Calendar
        .current
        .date(
          byAdding: .minute,
          value: minuteOffset,
          to: currentDate
        )!
      let entry = DateEntry(
        date: entryDate,
        configuration: configuration
      )
      entries.append(entry)
    }

    return Timeline(
      entries: entries,
      policy: .atEnd
    )
  }

   func snapshot(for configuration: DateConfiguration, in context: Context) async -> DateEntry {
     DateEntry(
       date: configuration.systemContext.preciseTimestamp ?? .now,
       configuration: configuration
     )
   }
}
