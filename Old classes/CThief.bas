B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	
	Private DEFAULT_QUALITY As Int = 10
	Private DEFAULT_IGNORE_WHITE As Boolean= True

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub


'    /**
'     * Use the median cut algorithm To cluster similar colors And Return the base color from the
'     * largest cluster.
'     *
'     * @param sourceImage
'     *            the source image
'     *
'     * @return the dominant color As RGB Array
'     */


Public Sub getColor(sourceImage As BitmapCreator) As ARGBColor
	
	Dim palette As Map
	palette.Initialize
	
	palette = getPalette(sourceImage, 5)
	
	If palette.Size = 0 Then
		Return Null
	End If
	
	Dim dominantColor As ARGBColor = palette.Get(0)
	Return dominantColor
End Sub

'    /**
'     * Use the median cut algorithm To cluster similar colors And Return the base color from the
'     * largest cluster.
'     *
'     * @param sourceImage
'     *            the source image
'     * @param quality
'     *            1 Is the highest quality settings. 10 Is the default. There Is a trade-off between
'     *            quality And speed. The bigger the number, the faster a color will be returned but
'     *            the greater the likelihood that it will Not be the visually most dominant color.
'     * @param ignoreWhite
'     *            If <code>True</code>, white pixels are ignored
'     *
'     * @return the dominant color As RGB Array
'     * @throws IllegalArgumentException
'     *             If quality Is &lt; 1
'     */

Public Sub getColor2(sourceImage As BitmapCreator, quality As Int, ignoreWhite As Boolean)  As ARGBColor
    
	Dim palette As Map
	palette.Initialize
	
	palette = getPalette2(sourceImage, 5, quality, ignoreWhite)
    
	If palette.Size=0 Then
		Return Null
	End If

	Dim dominantColor As ARGBColor = palette.Get(0)
	Return dominantColor

End Sub

'    /**
'     * Use the median cut algorithm To cluster similar colors.
'     * 
'     * @param sourceImage
'     *            the source image
'     * @param colorCount
'     *            the size of the palette; the number of colors returned
'     * 
'     * @return the palette As Array of RGB arrays
'     */

Public Sub getPalette(sourceImage As BitmapCreator, colorCount As Int) As Map
    Dim ccmap As CMap = getColorMap(sourceImage, colorCount)

    If ccmap .IsInitialized = False Then Return Null

    Return ccmap.palette
End Sub

'	/**
'	 * Use the median cut algorithm To cluster similar colors.
'	 * 
'	 * @param sourceImage
'	 *            the source image
'	 * @param colorCount
'	 *            the size of the palette; the number of colors returned
'	 * @param quality
'	 *            1 Is the highest quality settings. 10 Is the default. There Is a trade-off between
'	 *            quality And speed. The bigger the number, the faster the palette generation but
'	 *            the greater the likelihood that colors will be missed.
'	 * @param ignoreWhite
'	 *            If <code>True</code>, white pixels are ignored
'	 * 
'	 * @return the palette As Array of RGB arrays
'	 * @throws IllegalArgumentException
'	 *             If quality Is &lt; 1
'	 */
 
Public Sub getPalette2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As Map

    Dim ccmap As CMap = getColorMap2(sourceImage, colorCount, quality, ignoreWhite)
    
    If ccmap.IsInitialized = False Then Return Null

    Return ccmap.palette
End Sub

'    /**
'     * Use the median cut algorithm To cluster similar colors.
'     * 
'     * @param sourceImage
'     *            the source image
'     * @param colorCount
'     *            the size of the palette; the number of colors returned (minimum 2, maximum 256)
'     * 
'     * @return the color map
'     */

Public Sub getColorMap(sourceImage As BitmapCreator, colorCount As Int) As CMap
    Return getColorMap2(sourceImage, colorCount, DEFAULT_QUALITY, DEFAULT_IGNORE_WHITE)
End Sub

'    /**
'     * Use the median cut algorithm To cluster similar colors.
'     * 
'     * @param sourceImage
'     *            the source image
'     * @param colorCount
'     *            the size of the palette; the number of colors returned (minimum 2, maximum 256)
'     * @param quality
'     *            1 Is the highest quality settings. 10 Is the default. There Is a trade-off between
'     *            quality And speed. The bigger the number, the faster the palette generation but
'     *            the greater the likelihood that colors will be missed.
'     * @param ignoreWhite
'     *            If <code>True</code>, white pixels are ignored
'     * 
'     * @return the color map
'     * @throws IllegalArgumentException
'     *             If quality Is &lt; 1
'     */
 
 Public Sub getColorMap2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As CMap

	Dim pixels As List = getPixels(sourceImage)
	
	' Send Array To quantize function which clusters values using median cut algorithm
	Dim ccmap As CMap 
	ccmap.Initialize
	
	ccmap = ccmap.quantize(pixels, colorCount)
	
	Return ccmap
	
End Sub

Private Sub getPixels(image As BitmapCreator) As List
	
	Dim width As Int = image.mWidth
	Dim height As Int = image.mHeight
	
	Dim res, t As List
	t.Initialize
	res.Initialize

	Dim row, col As Int
			
	For row = 0 To height -1
		For col = 0 To width-1
			Dim ar As ARGBColor
			image.GetARGB (col, row, ar)

			If (ar.r > 250 And ar.g > 250 And ar.b >250) = False Then
				res.Add (ar)
			End If
		
		Next
	Next
	
	Return res
End Sub