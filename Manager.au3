#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:
   Caleb Alexander

 Script Function:
   Manager.

#ce ----------------------------------------------------------------------------
; Script Start - Add your code below here
#RequireAdmin
; ------------------------------------------------------------------------------
; Includes
; ------------------------------------------------------------------------------
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GuiEdit.au3>
#include <GuiRichEdit.au3>

; ------------------------------------------------------------------------------
; Opts
; ------------------------------------------------------------------------------
Opt("GUIOnEventMode", 0)

; ------------------------------------------------------------------------------
; GUI Globals
; ------------------------------------------------------------------------------
Global $GUI
Global $Menu, $ProfileMenu
Global $Banner
Global $ProfileListView
Global $Btn_RunProfile, $Btn_StopProfile, $Btn_EditProfile, $Btn_Setup
Global $Tab
Global $TabCommon, $EditCommon
Global $TabItem, $EditItem
Global $TabChat, $EditChat
Global $TabLevel, $EditLevel
Global $TabError, $EditError
Global $WIDTH = 800, $HEIGHT = 600

Global $GUI_Config, $GUI_CONFIG_IS_OPEN = False
Global $ConfigBanner
Global $InputProfileName, $D2Path, $CDKey, $CDKeyChangeNumber, $AccountName, $AccountPassword, $GameName, $GamePassword
Global $CheckBoxWindow, $CheckBoxNoSound, $CheckBoxLowQuality, $CheckBoxDirectTxt, $CheckBoxMinimized, $CheckBoxGameNameRandom, $CheckBoxGamePassRandom
Global $Btn_BrowseD2Path, $Btn_AutoDetectPath, $Btn_OK, $Btn_CANCEL
Global $EntryPointDropDownMenu, $PlayTypeMenu, $DifficultyMenu, $ServerMenu
Global $Radio1, $Radio2, $Radio3, $Radio4, $Radio5, $Radio6, $Radio7, $Radio8

Global $LoadedProfileArray[32]
Global $LoadedProfiles = 0

Global $ManagerConfigFile = @ScriptDir & "/" & "Clobot.ini"
Main()

Func Main()
   LoadGUI()
   _LoadProfiles()
   While 1
	  If $GUI_CONFIG_IS_OPEN Then
		 GUIConfigLoop()
		 Sleep(10)
	  Else
		 MainGUILoop()
		 Sleep(10)
	  EndIf
   WEnd
EndFunc


Func MainGUILoop()
   Local $Msg = GUIGetMsg()
   Switch $Msg
	  Case $Btn_RunProfile
		 _RunProfile()
	  Case $Btn_StopProfile
		 MsgBox(0, "", "Not implemented yet")
	  Case $Btn_EditProfile
		 MsgBox(0, "", "Not implemented yet")
	  Case $Btn_Setup
		 LoadConfigGUI()
	  Case $GUI_EVENT_CLOSE
		 _Close()
   EndSwitch
EndFunc


Func GUIConfigLoop()
   Local $Msg = GUIGetMsg()
   Switch $Msg
	  Case $Btn_BrowseD2Path
		 ;MsgBox(0, "", "Not implemented yet")
	  Case $Btn_AutoDetectPath
		 ;MsgBox(0, "", "Not implemented yet")
	  Case $Btn_OK
		 ;MsgBox(0, "", "Not implemented yet")
	  Case $Btn_CANCEL
		 ;MsgBox(0, "", "Not implemented yet")
	  Case $GUI_EVENT_CLOSE
		 _Close()
   EndSwitch
EndFunc

Func LoadConfigGUI()
   $GUI_CONFIG_IS_OPEN = True

   Local $ConfigWidth = 600
   Local $ConfigHeight = 480

   Local $mwpos = WinGetPos("CloBot Manager")
   $mwpos[0] = $mwpos[0] + ($WIDTH/2) - ($ConfigWidth/2)
   $mwpos[1] = $mwpos[1] + ($HEIGHT/2) - ($ConfigHeight/2)

   $GUI_Config = GUICreate("Configuration", $ConfigWidth, $ConfigHeight, $mwpos[0], $mwpos[1])

   GUICtrlCreateLabel( "Profile Name", 15, 100, 100, 18)

   GUISetState(@SW_SHOW, $GUI_Config)
EndFunc

Func LoadGUI()

   $WIDTH = 800
   $HEIGHT = 600

   $GUI = GUICreate("CloBot Manager", $WIDTH, $HEIGHT, 192, 124)

   $Menu = GUICtrlCreateMenu("Menu")
   $ProfileMenu = GUICtrlCreateMenu("Run Profile", $Menu, 0)
   $Banner = GUICtrlCreatePic(@ScriptDir & "\Banner.jpg", 5, 5, $WIDTH - 10, 102)

   $ProfileListView = GUICtrlCreateListView("#|Profile|Character|Account|Area|Restarts|Runs|Chickens|Deaths|Success", 5, 112, $WIDTH - 10, 158)
   $Temp = GUICtrlCreateListViewItem( "1|Baal Leader|Clobie|Clobie7|In Game[IP:72] (5m 13s)|13|67|1|3|94%", $ProfileListView )
   GUICtrlDelete($Temp)
   $Btn_RunProfile = GUICtrlCreateButton("Run", 5, 275, 75, 25)
   $Btn_StopProfile = GUICtrlCreateButton("Stop", 85, 275, 75, 25)
   $Btn_EditProfile = GUICtrlCreateButton("Edit", 165, 275, 75, 25)
   $Btn_Setup = GUICtrlCreateButton("Setup", 245, 275, 75, 25)

   $Tab = GUICtrlCreateTab(5, 307, $WIDTH - 10, 255)
   $TabCommon = GUICtrlCreateTabItem("Common")
   $EditCommon = GUICtrlCreateEdit( "", 10, 332, $WIDTH - 268, 224, $ES_READONLY + $WS_VSCROLL )
   $TabItem = GUICtrlCreateTabItem("Item")
   $EditItem = GUICtrlCreateEdit( "", 10, 332, $WIDTH - 268, 224, $ES_READONLY + $WS_VSCROLL )
   $TabChat = GUICtrlCreateTabItem("Chat")
   $EditChat = GUICtrlCreateEdit( "", 10, 332, $WIDTH - 268, 224, $ES_READONLY + $WS_VSCROLL )
   $TabLevel = GUICtrlCreateTabItem("Exp")
   $EditLevel = GUICtrlCreateEdit( "", 10, 332, $WIDTH - 268, 224, $ES_READONLY + $WS_VSCROLL )
   $TabError = GUICtrlCreateTabItem("Error")
   $EditError = GUICtrlCreateEdit( "", 10, 332, $WIDTH - 268, 224, $ES_READONLY + $WS_VSCROLL )
   GUICtrlSetFont( $EditCommon, 9, 400, 0, "Lucidia Console" )
   GUICtrlSetFont( $EditItem, 9, 400, 0, "Lucidia Console" )
   GUICtrlSetFont( $EditChat, 9, 400, 0, "Lucidia Console" )
   GUICtrlSetFont( $EditLevel, 9, 400, 0, "Lucidia Console" )
   GUICtrlSetFont( $EditError, 9, 400, 0, "Lucidia Console" )
   GUISetState(@SW_SHOW, $GUI)

   GUIRegisterMsg($WM_COPYDATA, "ReceiveWMCopyData")

EndFunc

Func _Close()
   If $GUI_CONFIG_IS_OPEN == True Then
	  GUIDelete($GUI_Config)
	  $GUI_CONFIG_IS_OPEN = False
	  Sleep(100)
   ElseIf $GUI_CONFIG_IS_OPEN == False Then
	  Exit
   EndIf
EndFunc

Func _LoadProfiles()
   Local $Profile[16][4]
   Local $i = 0
   While 1
	  $Profile[$i][0] = IniRead($ManagerConfigFile, "Profile" & $i+1, "Number", 0)
	  $Profile[$i][1] = IniRead($ManagerConfigFile, "Profile" & $i+1, "Profile", 0)
	  $Profile[$i][2] = IniRead($ManagerConfigFile, "Profile" & $i+1, "Character", 0)
	  $Profile[$i][3] = IniRead($ManagerConfigFile, "Profile" & $i+1, "Account", 0)
	  If $Profile[$i][0] == 0 Then
		 ExitLoop
	  Else
		 $LoadedProfileArray[$LoadedProfiles] = GUICtrlCreateListViewItem($Profile[$i][0] & "|" & $Profile[$i][1] & "|" & $Profile[$i][2] & "|" & $Profile[$i][3], $ProfileListView)
		 $LoadedProfiles = $LoadedProfiles + 1
	  EndIf
	  $i = $i + 1
   WEnd
EndFunc

Func _RunProfile()
   Local $selected = GUICtrlRead(GUICtrlRead($ProfileListView))
   If Not $selected <> "" Then
	  MsgBox(16, "Error", "Please select a profile first!")
	  Return
   Else
	  Local $Pids[128], $x = 0
	  Local $ProcessList = ProcessList()
	  For $i = 2 To UBound($ProcessList)-1
		 If $ProcessList[$i][0] == "Game.exe" Then
			$Pids[$x] = $ProcessList[$i][1]
			$x = $x + 1
		 EndIf
	  Next

	  RunWait("C:\Program Files (x86)\Diablo II\Diablo II.exe -w", "C:\Program Files (x86)\Diablo II\")

	  Local $Pids2[128], $x2 = 0
	  Local $ProcessList2 = ProcessList()
	  For $i = 2 To UBound($ProcessList2)-1
		 If $ProcessList2[$i][0] == "Game.exe" Then
			$Pids2[$x] = $ProcessList2[$i][1]
			$x2 = $x2 + 1
		 EndIf
	  Next

	  If $x2 > $x Then
		 For $i = 0 To $x2
			For $j = 0 To $x
			   If $Pids[$j] == $Pids2[$i] Then
				  $Pids2[$i] = 0
				  ContinueLoop
			   EndIf
			Next
		 Next
		 For $l = 0 To UBound($Pids2)-1
			If $Pids2[$l] == 0 Then
			   ContinueLoop
			Else
			   Local $Split = StringSplit($selected, "|", 1)
			   GUICtrlSetData($LoadedProfileArray[$Split[1]-1], "||||" & "Loading")
			   Sleep(750)
			   If _Inject($Pids2[$l]) Then
				  GUICtrlSetData($LoadedProfileArray[$Split[1]-1], "||||" & "Splash")
			   EndIf
			   ExitLoop
			EndIf
		 Next
	  Else
		 MsgBox(0, "Error", "Something went wrong trying to inject")
	  EndIf
   EndIf
EndFunc

Func _Inject($PID)
   Local $run = @ScriptDir & "\Bin\" & "Injector.exe" & ' "' & "CloBot.dll" & '" "' & $PID & '"'
   Local $dir = @ScriptDir & "\Bin\"
   If RunWait($run, $dir, 1) Then
	  Return True
  EndIf
  Return False
EndFunc

Func ReceiveWMCopyData($hWnd, $msgID, $wParam, $lParam)
   $copyData = DllStructCreate("ulong_ptr;dword;ptr", $lParam)

   $dwData = DllStructGetData($copyData, 1)
   $cbData = DllStructGetData($copyData, 2)
   $lpData = DllStructGetData($copyData, 3)

   $content = DllStructGetData(DllStructCreate("wchar[" & $cbData & "]", $lpData), 1)

   MsgBox(0, "", $content & @CRLF & @CRLF & $dwData & @CRLF & @CRLF & $cbData)
EndFunc   ;==>ReceiveWMCopyData


