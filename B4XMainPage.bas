B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals

	#if b4j
		Private fx As JFX
	#Else
		Private Button2 As B4XView
		Dim camera As Camera
	#End If
	
	Private Root As B4XView
	Private xui As XUI
	Private ImageView1 As B4XView
	Private Button1 As B4XView
	Private CustomListView1 As CustomListView
	
	Private pic_num As Int = 1
	
	
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	#if B4i
		camera.Initialize("Camera", B4XPages.GetNativeParent(Me))
	#end if
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	
	CustomListView1.Clear
	
	Dim bc As BitmapCreator
	bc.Initialize (1,1)
	
	Dim CF As ColourThief
	CF.Initialize
	
	Dim m As Map = CF.getPalette (ImageView1.GetBitmap, 8)
	
	#if b4i or b4a
		Dim x As Int
	#End If
	
	For Each c As ARGBColor In m.Values
		Dim pnl As B4XView = xui.CreatePanel ("")

		Dim DispColour As Int = bc.ARGBToColor (c)
		
		#if b4j
			pnl.Height = 45dip
		#else
			pnl.SetLayoutAnimated (0,0,x*45dip,100%x,45dip)
			x=x+1
		#End If
	
		pnl.Color = DispColour
		CustomListView1.Add (pnl, 0)
	Next

End Sub

#if b4j
Private Sub ImageView1_MouseClicked (EventData As MouseEvent)
	
	pic_num = pic_num + 1
	If pic_num = 4 Then pic_num = 1
	ImageView1.SetBitmap(fx.LoadImage(File.DirAssets, "photo" & pic_num & ".jpg"))
	
End Sub

#Else
Private Sub ImageView1_Click

	pic_num = pic_num + 1
	If pic_num = 4 Then pic_num = 1

	Dim b As Bitmap = LoadBitmap (File.DirAssets, "photo" & pic_num & ".jpg")
	
	ImageView1.SetBitmap (b)

End Sub

Private Sub Button2_Click
	
	'Load an image from the camera roll
	TakePicture (ImageView1.Width, ImageView1.Height)
	
	Wait For Image_Available(Success As Boolean, bmp As B4XBitmap)
	If Success Then
		ImageView1.SetBitmap(bmp)
	End If
	
End Sub

	
Private Sub TakePicture (TargetWidth As Int, TargetHeight As Int)
	camera.SelectFromPhotoLibrary (ImageView1, camera.TYPE_IMAGE)
	
	Dim TopPage As String = B4XPages.GetManager.GetTopPage.Id
	Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)
	B4XPages.GetManager.mStackOfPageIds.Add(TopPage) 'this is required as the page will be removed from the stack when the external camera page appears.
	If Success Then
		Dim bmp As B4XBitmap = Image
		bmp.Resize(TargetWidth, TargetHeight, True)
		ImageView1.SetBitmap (bmp)
	end If
End Sub
#End If


