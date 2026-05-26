## ColourThief

I needed a fully cross platform colour palette generator for an ongoing project and I initially converted a KMeans algorithm to B4X however I faced a couple of issues with it. Mainly the fact that random points are used as starting points so running the code multiple times gives different results. Also I simply couldn't get it to run particularly quickly on IOS.  
  
A bit of searching came up with this algorithm written in Java so here it is converted to B4X. Benefits with this - 1 - You will always get the same palette given the same image. 2 - Very fast on all platforms.

Use:  
  
  

B4X:

```b4x
    Dim CF As ColourThief
    CF.Initialize
```

  
Then the functions you're interested in are  
  
  

B4X:

```b4x
' Returns the single most dominant colour as an ARGBColor value
' Req - sourceImage As B4XBitmap - Any size bitmap - it will be converted/optimised within the class

Public Sub getDominantColor(sourceImage As B4XBitmap) As ARGBColor

' More control here - quality (default is 10) is how many pixels to skip between samples
' ignoreWhite (default True) simply skips any white pixels it detects.

Public Sub getDominantColor2(sourceImage As BitmapCreator, quality As Int, ignoreWhite As Boolean)  As ARGBColor

'Returns a map of ARGBColor values, set how many with colorCount
'Ordered by most dominant to least dominant
'colorCount should be 2 - 255

Public Sub getPalette(sourceImage As B4XBitmap, colorCount As Int) As Map

'As previous with more control

Public Sub getPalette2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As Map

'And finally a CMap object is a list of VBox classes used to quantize each of the colours using Mediancuts.
'There's more information in here about each colour selected such as count, average, histograms etc.
'Probably of very little use.

Public Sub getColorMap(sourceImage As B4XBitmap, colorCount As Int) As CMap

Public Sub getColorMap2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As CMap
```

  
Demo grab of an 8 colour palette.  
  

![Capture.JPG](https://www.b4x.com/android/forum/attachments/capture-jpg.126679/ "Capture.JPG")
