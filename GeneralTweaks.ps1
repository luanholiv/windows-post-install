# Este script realiza ajustes gerais no Windows.
# Revise os itens pois sua necessidade pode ser diferente. 

function updateExecutionPolicy {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        exit;
    }
}

function configureWindowsExplorer {
    Set-Itemproperty -Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -Value 1 -Force

    Write-Output "Windows Explorer configurado."
}

function disableBingSearch {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Force 
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -Force
   
    Write-Output "Bing Search desativado."
}

function removeContentDeliveryManager {
    Remove-Item -Path "HKCU:\*\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\*" -Recurse

    Remove-ItemProperty -Path "HKCU:\*\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" -Name "SubscribedContent-*Enabled"

    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "FeatureManagementEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SlideshowEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -Force 
    Set-Itemproperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Force 
    
    Write-Output "ContentDeliveryManager removido."
}

function removeWindowsServices {
    Set-Service Fax -StartupType Disabled
    Set-Service WerSvc -StartupType Disabled
    Set-Service PhoneSvc -StartupType Disabled
    Set-Service TapiSrv -StartupType Disabled
    Set-Service MapsBroker -StartupType Disabled
    Set-Service OneSyncSvc -StartupType Disabled
    Set-Service PcaSvc -StartupType Disabled
    Set-Service MessagingService -StartupType Disabled
    Set-Service RetailDemo -StartupType Disabled
    Set-Service diagnosticshub.standardcollector.service -StartupType Disabled
    Set-Service lfsvc -StartupType Disabled
    Set-Service AJRouter -StartupType Disabled
    Set-Service RemoteRegistry -StartupType Disabled
    Set-Service DusmSvc -StartupType Disabled
    Set-Service DiagTrack -StartupType Disabled
    Set-Service XblAuthManager -StartupType Disabled
    Set-Service XblGameSave -StartupType Disabled
    Set-Service XboxNetApiSvc -StartupType Disabled
    Set-Service XboxGipSvc -StartupType Disabled

    Stop-Service DiagTrack
	Set-Service DiagTrack -StartupType Disabled

    Write-Output "Serviços desativados."
}

function disableScheduledTasks {
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyMonitor | Disable-ScheduledTask
    Get-ScheduledTask  MapsUpdateTask | Disable-ScheduledTask
    Get-ScheduledTask  MapsToastTask | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyMonitor | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyMonitorToastTask | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyRefreshTask | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyRefresh | Disable-ScheduledTask
    Get-ScheduledTask  FamilySafetyUpload | Disable-ScheduledTask

    Write-Output "Tarefas agendadas desativadas."
}

updateExecutionPolicy

configureWindowsExplorer
disableBingSearch
removeContentDeliveryManager
removeWindowsServices
disableScheduledTasks

pause
