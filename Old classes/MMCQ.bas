B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	
	Private SIGBITS As Int = 5

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'    /**
'     * Get reduced-space color index For a pixel.
'     * 
'     * @param r
'     *            the red value
'     * @param g
'     *            the green value
'     * @param b
'     *            the blue value
'     * 
'     * @return the color index
'     */
    
Public Sub getColorIndex(r As Int, g As Int, b As Int) As Int
    Return (Bit.ShiftLeft (r , (2 * SIGBITS)) + (Bit.ShiftLeft(g , SIGBITS)) + b)
End Sub