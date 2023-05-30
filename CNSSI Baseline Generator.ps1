<#
.SYNOPSIS
	Creates a baseline of NIST 800-53 Rev. 4 security controls based off of user-provded impact categories. 

.DESCRIPTION
	user must modufy the file paths for variables savepath, savepath2 and for all Import-Csv statements. This program must be accompanied by the bok3 csv that has the CNSSI 1253 controls.

.PARAMETER x
	x

.PARAMETER x
	x
	
.PARAMETER WQLFilter
	x
	
.EXAMPLE
	x
	
.EXAMPLE
	x

.LINK
	x

.NOTES
	x
#>



function Main(){

function confidentialityChoice(){
$searchterm='X'

$savepath='C:\Users\14693\Documents\baselinetst.csv'
$savepath2='C:\Users\14693\Documents\curatedbaselinetest.csv'

$High=New-Object System.Management.Automation.Host.ChoiceDescription '&High', 'Confimpactlevel: High'
$Moderate=New-Object System.Management.Automation.Host.ChoiceDescription '&Moderate', 'Confimpactlevel: Moderate'
$Low=New-Object System.Management.Automation.Host.ChoiceDescription '&Low', 'Confimpactlevel: Low'

$options=[System.Management.Automation.Host.ChoiceDescription[]]($High, $Moderate, $Low)
$title='Confidentiality Impact Level'
$Message='What is the impact rating for confidentiality?'
$Resultsforconf=$host.ui.PromptForChoice($title, $Message, $options, 0)
if($Resultsforconf -eq 0){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.conhigh -match $searchterm} | select-object -Property family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation
$Script:ConfImpactLevel = "H"
$ConfImpactLevel= 'H'}

elseif($Resultsforconf -eq 1){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.conmed -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description |  Export-Csv -path $savepath -NoTypeInformation

$Script:ConfImpactLevel = "M"}
elseif($Resultsforconf -eq 2){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.conlow -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation
$Script:ConfImpactLevel = "L"}

}


function integrityChoice(){
$searchterm='X'

$savepath='C:\Users\14693\Documents\baselinetst.csv'
$savepath2='C:\Users\14693\Documents\curatedbaselinetest.csv'

$High=New-Object System.Management.Automation.Host.ChoiceDescription '&High', 'Integlevel: High'
$Moderate=New-Object System.Management.Automation.Host.ChoiceDescription '&Moderate', 'Integlevel: Moderate'
$Low=New-Object System.Management.Automation.Host.ChoiceDescription '&Low', 'Integlevel: Low'

$options=[System.Management.Automation.Host.ChoiceDescription[]]($High, $Moderate, $Low)
$title='Integrity Impact Level'
$Message='What is the impact rating for integrity?'
$Resultsforinteg=$host.ui.PromptForChoice($title, $Message, $options, 0)



if($Resultsforinteg -eq 0){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.integhigh -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation -Append 
$Script:IntegRating='H'
}
elseif($Resultsforinteg -eq 1){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.integmed -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description |  Export-Csv -path $savepath -NoTypeInformation -Append 
$Script:IntegRating='M'
}
elseif($Resultsforinteg -eq 2){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.integlow -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation -Append
$Script:IntegRating='L'}
}

function AvailabilityChoice(){
$searchterm='X'

$savepath='C:\Users\14693\Documents\baselinetst.csv'
$savepath2='C:\Users\14693\Documents\curatedbaselinetest.csv'

$High=New-Object System.Management.Automation.Host.ChoiceDescription '&High', 'Availlevel: High'
$Moderate=New-Object System.Management.Automation.Host.ChoiceDescription '&Moderate', 'Availlevel: Moderate'
$Low=New-Object System.Management.Automation.Host.ChoiceDescription '&Low', 'Availlevel: Low'

$options=[System.Management.Automation.Host.ChoiceDescription[]]($High, $Moderate, $Low)
$title='Availability Impact Level'
$Message='What is the impact rating for Availability?'
$Resultsforavail=$host.ui.PromptForChoice($title, $Message, $options, 0)

if($Resultsforavail -eq '0'){

Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.availhigh -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation -Append
$Script:Availlevel='H'}

elseif($Resultsforavail -eq '1'){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.availmed -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description |  Export-Csv -path $savepath -NoTypeInformation -Append
$Script:Availlevel='M'}

elseif($Resultsforavail -eq '2'){
Import-Csv 'C:\users\14693\OneDrive\Documents\book3.csv' | ?{$_.availlow -match $searchterm} | select-object -Property Family, Major_control,Sub-part,Description | Export-Csv -path $savepath -NoTypeInformation -Append
$Script:Availlevel='L'}

}

function baseline(){


$savepath='C:\Users\14693\Documents\baselinetst.csv'
$savepath2='C:\Users\14693\Documents\curatedbaselinetest.csv'

confidentialityChoice

integrityChoice

AvailabilityChoice

$inputcsv=Import-Csv $savepath | Sort-Object * -Unique
$inputcsv | Export-Csv -Path $savepath2 -NoTypeInformation






}

baseline

Write-Host "Baseline for categorization $ConfImpactLevel - $IntegRating - $Availlevel has been written to $savepath2"


}

Main