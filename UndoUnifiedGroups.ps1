
$Title = "Convert Unified Groups to Distribution Lists"
$Info = "O365Inside.com By: Clint Oliveira"
 
$options = [System.Management.Automation.Host.ChoiceDescription[]] @("&One Group", "&All Groups", "&Quit")
[int]$defaultchoice = 0
$opt = $host.UI.PromptForChoice($Title , $Info , $Options,$defaultchoice)
switch($opt)
{
0 { Write-Host "One Group" -ForegroundColor Green
$ID= Read-Host "Please enter the email address of the group that you want to convert:"
$Groups = Get-UnifiedGroup -Identity $id
$Groups | ForEach-Object {
$group = $_
$GroupEmail = Get-UnifiedGroup -Identity $group.Name | select PrimarySmtpAddress
Get-UnifiedGroupLinks -Identity $group.Name -LinkType Members | ForEach-Object {
      New-Object -TypeName PSObject -Property @{
       Group = $group.DisplayName
       GroupEmail = $GroupEmail.primarysmtpaddress
       Member = $_.Name
       EmailAddress = $_.PrimarySMTPAddress
       RecipientType= $_.RecipientType
    
}}}| Export-CSV "C:\UnifiedGroupMembers.csv" -NoTypeInformation -Encoding UTF8
$distro = Import-Csv C:\UnifiedGroupMembers.csv | sort GroupEmail –Unique
$distro | foreach{Remove-UnifiedGroup -Identity $_.GroupEmail -force -Confirm:$false }
Start-Sleep -s 30
$distro | foreach{New-DistributionGroup -Name $_.Group -primarysmtpaddress $_.GroupEmail}
Import-CSV "C:\UnifiedGroupMembers.csv" | foreach {Add-DistributionGroupMember -identity $_.GroupEmail -member $_.EmailAddress} 
	}
1 { Write-Host "All Unified Groups" -ForegroundColor Green
$Groups = Get-UnifiedGroup -ResultSize Unlimited
$Groups | ForEach-Object {
$group = $_
$GroupEmail = Get-UnifiedGroup -Identity $group.Name | select PrimarySmtpAddress
Get-UnifiedGroupLinks -Identity $group.Name -LinkType Members | ForEach-Object {
      New-Object -TypeName PSObject -Property @{
       Group = $group.DisplayName
       GroupEmail = $GroupEmail.primarysmtpaddress
       Member = $_.Name
       EmailAddress = $_.PrimarySMTPAddress
       RecipientType= $_.RecipientType

}}}|
Export-CSV "C:\UnifiedGroupMembers.csv" -NoTypeInformation -Encoding UTF8
$distro = Import-Csv C:\UnifiedGroupMembers.csv | sort GroupEmail –Unique
$distro | foreach{Remove-UnifiedGroup -Identity $_.GroupEmail -force}
Start-Sleep -s 30
$distro | foreach{New-DistributionGroup -Name $_.Group -primarysmtpaddress $_.GroupEmail}
Import-CSV "C:\UnifiedGroupMembers.csv" | foreach {Add-DistributionGroupMember -identity $_.GroupEmail -member $_.EmailAddress} 
}
2 { Write-Host "Thank you for using this script. Good Bye!!!" -ForegroundColor Green
	}
}
