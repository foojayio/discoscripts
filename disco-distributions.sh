#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#    disco-distributions.sh    #"
    echo "#                              #"
    echo "################################"
    echo 
    echo
    echo "Be aware that you need to have jq installed"
    echo
    echo "Script parameters:"
    echo "--version : Returns a list of distributions that support the given version"
    echo "--name    : Returns a distribution with the given name if available"
    echo "--help    : Shows this info"    
    echo 
    echo "disco-distributions.sh"
    echo "disco-distributions.sh --version 13.0.5.1"
    echo "disco-releases.sh --help"
    echo
    exit 1
}


# FIELDS
versionField="version"
nameField="name"


# CHECK FOR GIVEN PARAMETERS
while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param=$2
    
        if [ "$param" = "$versionField" ]; then
            declare versionValue=$2        
        elif [ "$param" = "$nameField" ]; then
            declare nameValue=$2        
        fi

        if [ "$1" == "--help" ]; then
          infoFunction
        fi
   fi

  shift
done


# CALL THE DISCOAPI
url="https://api.foojay.io/disco/v1.0/distributions"

echo $versionValue

if [[ $versionValue ]]; then     
    url="${url}/versions/${versionValue}"
elif [[ $nameValue ]]; then     
    url="${url}/${nameValue}"    
fi


echo $url

# READ REST RESPONSE INTO VARIABLE
json="$(curl ${url} 2>/dev/null)"
#echo $json

# PRINT OUT
echo "$json" | jq
