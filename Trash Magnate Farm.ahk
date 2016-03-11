#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;==================================================================

;TORCHLIGHT 2 TRASH MAGANATE ACHIEVEMENT FARM

;V0.1 - working on resolution 1366*768
; bugs
; 1) some items get missed. Modifying delays to fix.

;controls:
;F5 to start your farm
;F6 to start/stop color and coordinate find
;F8 HOLD to stop.

; Big thanks to WIKING for his/her Fishing AHK script, which inspired this one.
; FOR LAZINESS.

; instructions (make sure you got a full inventory)
; 1) Set nSell_ and nBuy_ position variables.
; 2) If you like, set the n_Distance variables. I find 42 hits the center of the item every time. (yeah i know that reference)
; 3) Go to your favourite seller, click on them.
; 4) Start the farm with F5, stop it by holding F8.
; 5) Profit.
; 6) If there are any bugs feel free to change the script or let me know on GitHub.


;==================================================================

; set variables here
; sell from player inventory (starts from top left of the player inventory) (use F6 to find out)
nSell_StartX = 1037
nSell_StartY = 424

; buy from seller inventory (starts from top left of the seller inventory) (use F6 to find out)
nBuy_StartX = 23
nBuy_StartY = 155

; distance between each item (42 is pretty much perfect, just like 42 was from that one movie)
nXDistance = 42
nYDistance = 42

; miscelleneous
nXCounter = 0
nYCounter = 0

; 0 is sell, 1 is buy
nBuySell = 0

F5::
loop{
	if BreakLoop = 1
	{
		BreakLoop = 0
		break
		nXCounter = 0
		nYCounter = 0
		ToolTip 
	}
	
	if(nBuySell == 0)
	{
		Send, {LShift down}
		Sleep 70
		MouseMove (nSell_StartX+(nXCounter*nXDistance)),(nSell_StartY+(nYCounter*nYDistance))
		Sleep 40
		Send, {LButton down}
		Sleep 40
		Send, {LButton up}
		Sleep 40
		Send, {LShift up}
		Sleep 70
			
		Sleep 1
		nXCounter++
		if (nXCounter == 8){
			nXCounter = 0
			nYCounter++
		}
		
		if(nYCounter == 4){
			nBuySell = 1
			nXCounter = 0
			nYCounter = 0
		}
	}
	
	else if(nBuySell == 1)
	{
		Send, {LShift down}
		Sleep 70
		MouseMove (nBuy_StartX+(nXCounter*nXDistance)),(nBuy_StartY+(nYCounter*nYDistance))
		Sleep 40
		Send, {LButton down}
		Sleep 40
		Send, {LButton up}
		Sleep 40
		Send, {LShift up}
		Sleep 70
		
		Sleep 1
		nXCounter++
		if (nXCounter == 8){
			nXCounter = 0
			nYCounter++
		}
		
		if(nYCounter == 4){
			nBuySell = 0
			nXCounter = 0
			nYCounter = 0
		}
	}
	
}
    
return

#MaxThreadsPerHotkey = 2
F6::
Toggle := !Toggle
While Toggle {
   MouseGetPos Xpos, Ypos
   PixelGetColor Colour, %Xpos%, %Ypos%, RGB
   StringTrimLeft Colour, Colour, 2               ; Remove 0x
   ToolTip %Colour% X%Xpos% Y%Ypos%
   }
ToolTip
Return

F8::
if BreakLoop = 1
{
	
}
else
{
	BreakLoop = 1
}
return