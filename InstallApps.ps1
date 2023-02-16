# Este script instala aplicações que utilizo frequentemente. Note que sua necessidade pode ser diferente. 
# É necessário ter o winget instalado. Uma alternativa a este script é utilizar o comando winget import com a lista de apps desejadas.

function updateExecutionPolicy {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        exit;
    }
}

function installProductivityApps {
    winget install --accept-package-agreements --accept-source-agreements -e --id Bitwarden.Bitwarden;
    winget install --accept-package-agreements --accept-source-agreements -e --id Twilio.Authy
    winget install --accept-package-agreements --accept-source-agreements -e --id Mozilla.Firefox;
    winget install --accept-package-agreements --accept-source-agreements -e --id Mega.MEGASync;
    winget install --accept-package-agreements --accept-source-agreements -e --id 7zip.7zip;
    winget install --accept-package-agreements --accept-source-agreements -e --id M2Team.NanaZip; 
    winget install --accept-package-agreements --accept-source-agreements -e --id Corsair.iCUE.4;
    winget install --accept-package-agreements --accept-source-agreements -e --id CPUID.CPU-Z.GBT;
    winget install --accept-package-agreements --accept-source-agreements -e --id Samsung.DeX;
    
    Write-Output "Apps de produtividade instaladas."
}

function installMultimediaApps {
    winget install --accept-package-agreements --accept-source-agreements -e --id Spotify.Spotify;
    winget install --accept-package-agreements --accept-source-agreements -e --id VideoLAN.VLC;
    
    Write-Output "Apps de multimídia instaladas."
}

function installCommunicationApps {
    winget install --accept-package-agreements --accept-source-agreements -e --id WhatsApp.WhatsApp;
    winget install --accept-package-agreements --accept-source-agreements -e --id Telegram.TelegramDesktop;
    winget install --accept-package-agreements --accept-source-agreements -e --id Discord.Discord;
    
    Write-Output "Apps de comunicação instaladas."
}

function installDevApps {
    winget install --accept-package-agreements --accept-source-agreements -e --id Git.Git;
    winget install --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode -l 'C:\Program Files\Visual Studio Code';
    winget install --accept-package-agreements --accept-source-agreements -e --id Microsoft.PowerToys;
    
    Write-Output "Ambiente de dev instalado."
}

function installGamingApps {
    winget install --accept-package-agreements --accept-source-agreements -e --id Valve.Steam;
    winget install --accept-package-agreements --accept-source-agreements -e --id EpicGames.EpicGamesLauncher;
    winget install --accept-package-agreements --accept-source-agreements -e --id ElectronicArts.EADesktop;
    
    Write-Output "Apps de jogos instaladas."
}

updateExecutionPolicy

installProductivityApps
installMultimediaApps
installCommunicationApps
installDevApps
installGamingApps

pause
