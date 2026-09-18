# SwiftUISegmentControl
In our UIKit architecture, switching between tabs using a UISegmentedControl with a container view and child view controllers (UITableViewController) automatically preserves the scroll position of each individual list. Switching segments retains each controller's state and scroll offset in memory rather than resetting it.

To achieve this same user experience in SwiftUI, we need to replicate this persistent scroll behavior.

# Technical Objective:

Implement a segmented picker at the top of the Home screen.

Maintain independent scroll state tracking for each segment tab.

Utilize ScrollViewReader and onChange(of: selectedCategory) to programmatically restore the saved scroll position when switching between segments.
