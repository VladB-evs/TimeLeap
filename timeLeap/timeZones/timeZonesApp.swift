import SwiftUI

@main
struct TimeZoneMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
        self.popover = popover
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem?.button {
            statusButton.image = NSImage(systemSymbolName: "clock", accessibilityDescription: nil)
            statusButton.action = #selector(togglePopover)
        }
    }
    
    @objc func togglePopover() {
        if let button = statusItem?.button {
            if popover?.isShown == true {
                popover?.performClose(nil)
            } else {
                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedTimeZones: [String] = []
    let availableTimeZones = TimeZone.knownTimeZoneIdentifiers.sorted()
    @State private var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Time Zones")
                .font(.headline)
                .padding(.top)
            
            if selectedTimeZones.count < 3 {
                Menu("Add Time Zone") {
                    ForEach(availableTimeZones, id: \.self) { timezone in
                        if !selectedTimeZones.contains(timezone) {
                            Button(timezone.split(separator: "/").last?.replacingOccurrences(of: "_", with: " ") ?? timezone) {
                                selectedTimeZones.append(timezone)
                            }
                        }
                    }
                }
            }
            
            ForEach(selectedTimeZones, id: \.self) { timezone in
                TimeZoneView(timezone: timezone, currentDate: currentDate) {
                    selectedTimeZones.removeAll { $0 == timezone }
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 300)
        .onReceive(timer) { input in
            currentDate = input
        }
    }
}

struct TimeZoneView: View {
    let timezone: String
    let currentDate: Date
    let onRemove: () -> Void
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: currentDate)
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: currentDate)
    }
    
    var cityName: String {
        timezone.split(separator: "/").last?.replacingOccurrences(of: "_", with: " ") ?? timezone
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.headline)
                Text(timeString)
                    .font(.system(.title2, design: .monospaced))
                Text(dateString)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(timezone)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
}
