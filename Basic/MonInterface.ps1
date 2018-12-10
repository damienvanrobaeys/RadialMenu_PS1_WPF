[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
# [System.Reflection.Assembly]::LoadFrom('System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\RadialMenu.dll') | out-null  


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


$Close = $form.FindName("Close")
$MainMenu = $form.FindName("MainMenu")
$Open_Menu = $form.FindName("Open_Menu")

$SubMenu_1 = $form.FindName("SubMenu_1")
$SubMenu_Links = $form.FindName("SubMenu_Links")
$Open_OtherMenu = $form.FindName("Open_OtherMenu")
$Open_Features = $form.FindName("Open_Features")
$Open_MenuLinks = $form.FindName("Open_MenuLinks")

$Close_SubMenu_Links = $form.FindName("Close_SubMenu_Links")
$Close_SubMenu_1 = $form.FindName("Close_SubMenu_1")



$Open_Applis = $form.FindName("Open_Applis")
$Open_TaskManager = $form.FindName("Open_TaskManager")

$Open_JMK = $form.FindName("Open_JMK")
$Open_dev4sys = $form.FindName("Open_dev4sys")
$Open_sccm = $form.FindName("Open_sccm")
$Open_fox = $form.FindName("Open_fox")
$Open_adam = $form.FindName("Open_adam")
$Open_prateek = $form.FindName("Open_prateek")






$Open_Menu.Visibility = "Collapsed"

# Close Main menu
$Close.Add_Click({
	$MainMenu.IsOpen = $false
	$Open_Menu.Visibility = "Visible"
})

# Close the SubMenu links
$Close_SubMenu_Links.Add_Click({
	$SubMenu_Links.IsOpen = $false
	$MainMenu.IsOpen = $true
	$Open_Menu.Visibility = "Collapsed"
})


# Close the SubMenu 1
$Close_SubMenu_1.Add_Click({
	$SubMenu_1.IsOpen = $false
	$MainMenu.IsOpen = $true
	$Open_Menu.Visibility = "Collapsed"
})





# Open Main menu Button
$Open_Menu.Add_Click({
	$MainMenu.IsOpen = $true
	$Open_Menu.Visibility = "Collapsed"
})


# Open Links Menu
$Open_MenuLinks.Add_Click({
	$MainMenu.IsOpen = $false
	$Open_Menu.Visibility = "Collapsed"	
	$SubMenu_Links.IsOpen = $true	
})


# Open Other menu 
$Open_OtherMenu.Add_Click({
	$MainMenu.IsOpen = $false
	$Open_Menu.Visibility = "Collapsed"	
	$SubMenu_1.IsOpen = $true	
})





$Open_Features.Add_Click({
	start-process OptionalFeatures
})

$Open_Applis.Add_Click({
	start-process appwiz
})

$Open_TaskManager.Add_Click({
	start-process taskmgr
})



$Open_JMK.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("https://jm2k69.github.io/")
	$Browser.visible=$true		
})

$Open_dev4sys.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("https://www.dev4sys.com/")
	$Browser.visible=$true	
})

$Open_sccm.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("http://www.scconfigmgr.com/")
	$Browser.visible=$true	
})

$Open_fox.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("https://foxdeploy.com/")
	$Browser.visible=$true	
})

$Open_adam.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("https://www.asquaredozen.com/")
	$Browser.visible=$true	
})

$Open_prateek.Add_Click({
	$Browser=new-object -com internetexplorer.application
	$Browser.navigate2("https://ridicurious.com/")
	$Browser.visible=$true	
})




$Form.ShowDialog() | Out-Null

