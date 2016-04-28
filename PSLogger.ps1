#requires -version 2

<#
    .SYNOPSIS
    PSLogger Log Opener

    .DESCRIPTION
    Opens PSLogger Files

    .INPUTS
    [filename].psl
    

    .NOTES
    Version:        0.1
    Author:         Connor Unsworth
    Creation Date:  28 Apr 2016
    Purpose/Change: Provide password reminders for a variety of domains
  
#>


    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.DefaultExt = '.ps1'
    $dialog.Filter = 'PsLogger File|*.PSL|All Files|*.*'
    $dialog.FilterIndex = 0
    $dialog.InitialDirectory = $home
    $dialog.Multiselect = $false
    $dialog.RestoreDirectory = $true
    $dialog.Title = "Select a script file"
    $dialog.ValidateNames = $true
    $dialog.ShowDialog()
    $dialog.FileName

    if($dialog.FileName -eq $null)
    {exit}
    else
    {
        Import-CliXML $dialog.FileName | out-gridview -Title ($dialog.FileName.Split("\")[-1])
        pause
    }


