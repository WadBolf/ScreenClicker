# App Clicker
* [General info](#General-info)
* [Technologies](#Technologies)
* [Setup](#Setup)
* [Usage](#Usage)

## General info
This is a small PowerShell script to aid clicking of multiple on-screen items, this could be used for apps or games. This example has been setup to click the "ADD ALL" button for all items in the game Phasmophobia, running at 1920x1080 with 100% Windows desktop screen scaling.

## Technologies
This project was created with:
* PowerShell

## Setup
* Copy the PowerShell script (ScreenClicker.ps1) to any location on your hard drive, I suggest in your home folder, i.e. if your Windows username is Fred, then copy it to `C:\Users\Fred\ScreenClicker\`.
* Edit the script, and update the screen coordinates and Application name.
* Create a shortcut on your desktop and in the target box enter `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Users\Fred\ScreenClicker\ScreenClicker.ps1"` changing the path to where you placed ScreenClicker.ps1
* Drag the shostcut to your taskbar, the reason for this is to be able to run the powershell script when in a full screen app or game.

## Usage
Any time you wish to run the script, press the Windows key and click on the shortcut on the taskbar; the script will pull the app to the front, set focus and iterate through the coordinates clicking each screen position.
