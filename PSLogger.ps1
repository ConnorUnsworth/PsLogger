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


    
  [System.Windows.Forms.Application]::EnableVisualStyles();
  [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

  $file = (get-item 'splash.jpg')
  $img = [System.Drawing.Image]::Fromfile($file);
 
  
  $InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
  # Form Events
  $Form_StateCorrection_Load =
  {
    #Correct the initial state of the form to prevent the .Net maximized form 
    $form.WindowState = $InitialFormWindowState
  }
  
  $Form_Cleanup_FormClosed =
  {
    #Remove all event handlers from the controls
    try
    {
      $form.remove_Load($form_Load)
      $form.remove_Load($Form_StateCorrection_Load)
      $form.remove_FormClosed($Form_Cleanup_FormClosed)
    }
    catch [Exception]
    { }
  }


  $form = new-object Windows.Forms.Form
  $form.Width = $img.Size.Width;
  $form.Height =  $img.Size.Height;
  $pictureBox = new-object Windows.Forms.PictureBox
  $pictureBox.Width =  $img.Size.Width;
  $pictureBox.Height =  $img.Size.Height;

  $pictureBox.Image = $img;
  $form.controls.add($pictureBox)
  $form.Add_Shown( { $form.Activate() } )


  #
  $form.ControlBox = $False
  $form.Cursor = "AppStarting"
  $form.FormBorderStyle = 'FixedToolWindow'
  $form.Name = "NAME OF FORM"
  $form.ShowIcon = $False
  $form.ShowInTaskbar = $False
  $form.StartPosition = 'CenterScreen'
  $form.Text = "psLogger"
  
  #Save the initial state of the form
  $InitialFormWindowState = $form.WindowState
  #Init the OnLoad event to correct the initial state of the form
  $form.add_Load($Form_StateCorrection_Load)
  #Clean up the control events
  $form.add_FormClosed($Form_Cleanup_FormClosed)
  #Show the Form
  $form.Show() | Out-Null
  start-sleep -Seconds 2
  $form.Close()


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

    Import-CliXML $dialog.FileName | out-gridview -Title ($dialog.FileName.Split("\")[-1])
    pause

