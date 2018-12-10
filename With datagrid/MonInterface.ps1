[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
# [System.Reflection.Assembly]::LoadFrom('System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\RadialMenu.dll')      | out-null  
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null


function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml("MonInterface.xaml")
# $XamlMainWindow=LoadXml("MainWindow.xaml")


$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)


$Open_Menu = $form.FindName("Open_Menu")
$MyMenu = $form.FindName("MyMenu")
$Close_Menu = $form.FindName("Close_Menu")
$List_Users = $form.FindName("List_Users")
$List_Computers = $form.FindName("List_Computers")
$Open_TM = $form.FindName("Open_TM")
$Open_Features = $form.FindName("Open_Features")
$Open_Home = $form.FindName("Open_Home")
$Users_Block = $form.FindName("Users_Block")
$Computers_Block = $form.FindName("Computers_Block")
$Datagrid_Users = $form.FindName("Datagrid_Users")
$Datagrid_Computers = $form.FindName("Datagrid_Computers")
$Home_Page_Block = $form.FindName("Home_Page_Block")


$Users_Block.Visibility = "Collapsed"
$Computers_Block.Visibility = "Collapsed"
$Home_Page_Block.Visibility = "Visible"



$Close_Menu.Add_Click({
	$MyMenu.IsOpen = $false	
	If ($Users -eq $true)
		{
			$Users_Block.Visibility = "Visible"	
			$Computers_Block.Visibility = "Collapsed"						
		}
	Else
		{
			$Computers_Block.Visibility = "Visible"		
			$Users_Block.Visibility = "Collapsed"				
		}
})

$Open_Menu.Add_Click({
	$MyMenu.IsOpen = $true
	$Users_Block.Visibility = "Collapsed"
	$Computers_Block.Visibility = "Collapsed"	
	$Home_Page_Block.Visibility = "Collapsed"	
})

$List_Users.Add_Click({
	$MyMenu.IsOpen = $false
	$Users_Block.Visibility = "Visible"
	$Home_Page_Block.Visibility = "Collapsed"	
	Populate_Datagrid_Users
	$Global:Users = $true
	$Global:computers = $false
})

$List_Computers.Add_Click({
	$MyMenu.IsOpen = $false
	$Users_Block.Visibility = "Collapsed"
	$Home_Page_Block.Visibility = "Collapsed"	
	$Computers_Block.Visibility = "Visible"	
	Populate_Datagrid_Computers
	$Global:Users = $false
	$Global:computers = $true
})

$Open_Features.Add_Click({
	start-process OptionalFeatures
})

$Open_Home.Add_Click({
	$MyMenu.IsOpen = $false
	$Users_Block.Visibility = "Collapsed"
	$Computers_Block.Visibility = "Collapsed"	
	$Home_Page_Block.Visibility = "Visible"	
})

$Open_TM.Add_Click({
	start-process taskmgr
})


Function Populate_Datagrid_Users
	{
		$xmlFile = "Users.xml"
		$MyXML = [xml] (get-content $xmlFile)
		$Users = $MyXML.Users.User

		ForEach ($User in $Users)
			{
				$Values = New-Object PSObject
				$Values = $Values | Add-Member NoteProperty Nom $User.Nom -passthru	
				$Values = $Values | Add-Member NoteProperty Prenom $User.Prenom -passthru									
				$Values = $Values | Add-Member NoteProperty Ville $User.Ville -passthru	
				$Values = $Values | Add-Member NoteProperty Age $User.Age -passthru	
				$Datagrid_Users.Items.Add($Values) > $null						
			}			
	}


Function Populate_Datagrid_Computers
	{
		$xmlFile = "Computers.xml"
		$MyXML = [xml] (get-content $xmlFile)
		$Computers = $MyXML.Computers.Computer

		ForEach ($Computer in $Computers)
			{
				$Values = New-Object PSObject
				$Values = $Values | Add-Member NoteProperty Name $Computer.Name -passthru	
				$Values = $Values | Add-Member NoteProperty Town $Computer.Town -passthru									
				$Values = $Values | Add-Member NoteProperty OS $Computer.OS -passthru	
				$Datagrid_Computers.Items.Add($Values) > $null						
			}			
	}




$Form.ShowDialog() | Out-Null

