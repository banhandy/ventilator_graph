## GraphwithPointer for mimic Ventilator Monitor Graph

Recently people had been developing ventilator using Andruino and Flutter and one of the component needed is the Graphic showing input data from the sensor to the monitor. This widget use the same logic which had an index variable that can be use to update the data on the screen as we loop the pointer along the sccreen. The widget uses a List as the source of the data and also an index as pointer to display and will scale the information to fit the display. Take a look at the example to see how it can be used.

The display can be customised using the following values:
- backgroundColor : set the Background Color
- lineColor : set the Color
- segmentYColor : set the segment Y Color

The other settings are
- minY : set the minimal data Value
- maxY : set the maximum data Value
- index : set the current pointer
- dataSet : set List of the input data

minY and maxY are used by the widget to determine the scaling factor so all data values are displayed. These values can be altered to modify the data display scale. index will be used to show a moving block or pointer along the screen.

![Ventilator Graph Demo](demo.gif)
