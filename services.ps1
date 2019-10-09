$serviceList = Get-Service *$serviceUser*

if($serviceList.count -eq 0){
    Write-Host "Erreur : aucun service contenant '$serviceUser' trouvé..."
    exit 0
}

Write-Host "Voici les services trouvés : "

$i = 1
$result = @()
[System.Collections.ArrayList]$resultList = $result
$resultList.getType()

foreach($service in $serviceList){
    Write-Host  [$i] $service.name
    $state = $service.Status
    if($state -match "running"){
        $color = "Green"
    }else{
        $color = "Red"
    }
    write-host `t $service.Status -BackgroundColor $color
    $resultList.add($service.name)
    $i++
}

$choiceUser = Read-Host "Veuillez saisir le numéro de service "

while($choiceUser -notin 1..$resultList.Count){
    $choiceUser = Read-Host "Veuillez saisir le numéro de service "

}

$serviceChosen = $resultList[$choiceUser -1]
$getServiceUser = Get-service $serviceChosen
$state = $getServiceUser.status

 if($state -match "running"){
    #$action = Read-Host "Voulez vous arrêter le service ? [O/n]"
    if ((Read-Host "Voulez vous arrêter le service ? [O/n]") -match "O"){
        Stop-Service $serviceChosen -Verbose
    }
 }else {
    if ((Read-Host "Voulez vous démarrer le service ? [O/n]") -match "O"){
        Start-Service $serviceChosen -Verbose
    }
 }
