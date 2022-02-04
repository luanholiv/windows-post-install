# Este script remove todas as aplicações indesejadas que vêm com o Windows 10.
# Revise os itens pois sua necessidade pode ser diferente. 

function updateExecutionPolicy {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        exit;
    }
}

function removeUtilityApps {
    Get-AppxPackage -AllUsers *Microsoft.BingWeather* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.GetHelp* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Getstarted* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.MixedReality.Portal* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Office.OneNote* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.People* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Wallet* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.WindowsMaps* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.SkypeApp* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *microsoft.windowscommunicationsapps* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.OneConnect* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Messaging* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.BingNews* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Todos* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *MicrosoftTeams* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.ZuneVideo* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.ZuneMusic* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.MSPaint* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.YourPhone* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.WindowsCamera* | Remove-AppxPackage
    
    Write-Output "Apps utilitárias removidas."
}

function removeThirdyPartyApps {
    Get-AppxPackage -AllUsers *EclipseManager* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *ActiproSoftwareLLC* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Duolingo-LearnLanguagesforFree* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *PandoraMediaInc* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *CandyCrush* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *BubbleWitch3Saga* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Wunderlist* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Flipboard* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Twitter* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Facebook* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Spotify* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Minecraft* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Royal Revolt* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Sway* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Speed Test* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Disney* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Netflix* | Remove-AppxPackage
    
    Write-Output "Apps de terceiros removidas."
}

function removeXboxApps {
    Get-AppxPackage -AllUsers *Microsoft.XboxIdentityProvider* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.XboxGameOverlay* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.XboxApp* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.Xbox.TCUI* | Remove-AppxPackage
    Get-AppxPackage -AllUsers *Microsoft.GamingApp* | Remove-AppxPackage
    
    Write-Output "Apps do Xbox removidas."
}

function disableCortana {    
    Get-AppxPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage
    
    Write-Output "Cortana desativada."
}

function removeOneDrive {
    New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
	
    Stop-Process -Name "OneDrive*"
	Start-Sleep 2
	
    If (!(Test-Path $onedrive)) {
		$onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
	}
	
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
	Start-Sleep 2
    
    Start-Sleep 1
	taskkill.exe /F /IM explorer.exe
	Start-Sleep 3
    	
    Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
	Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
	Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
	
    If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
		Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
	}
       
    If (!(Test-Path $ExplorerReg1)) {
        New-Item $ExplorerReg1
    }
   
    Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
    If (!(Test-Path $ExplorerReg2)) {
        New-Item $ExplorerReg2
    }
    
    Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
    
    Start explorer.exe -NoNewWindow

    Write-Output "OneDrive removido."
}

updateExecutionPolicy

removeUtilityApps
removeThirdyPartyApps
removeXboxApps
removeCortana
removeOneDrive

pause
