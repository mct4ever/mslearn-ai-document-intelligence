: <<'END'
THIS PART DOES NOT MATTER FOR THE LAB, IT IS JUST TO SET UP THE RESOURCES THAT ARE ALLREADY CREATED
#~!/bin/bash

# Store color codes
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)

# Set up the resource group
resourceGroupName=FormsRecognizerResources
printf "${GREEN}Setting up the $resourceGroupName resource group. \n${NORMAL}"
az group create --location westus --name FormsRecognizerResources

# Create the Forms Recognizer resource
printf "${GREEN}Setting up the Forms Recognizer resource. \n${NORMAL}"
# First, purge it in case there's a recently deleted one
SubID=$(az account show --query id --output tsv)
az resource delete --ids "/subscriptions/${SubID}/providers/Microsoft.CognitiveServices/locations/westus/resourceGroups/${resourceGroupName}/deletedAccounts/FormsRecognizer"
az cognitiveservices account create --kind FormRecognizer --location swedencentral --name FormsRecognizer --resource-group $resourceGroupName --sku S0 --yes
# Create the Cognitive Search resource
printf "${GREEN}Setting up Azure Cognitive Search. \n${NORMAL}"
# Purge any existing search resource with the same name
az resource delete --ids "/subscriptions/${SubID}/resourceGroups/${resourceGroupName}/providers/Microsoft.Search/searchServices/enrichedcognitivesearch"
##
END
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
resourceGroupName=anlysisandextraction

# Create the Cognitive Search resource
printf "${GREEN}Setting up Azure Cognitive Search. \n${NORMAL}"
# Purge any existing search resource with the same name
az resource delete --ids "/subscriptions/${SubID}/resourceGroups/${resourceGroupName}/providers/Microsoft.Search/searchServices/enrichedcognitivesearch"
# Now, create the new one
az search service create --name enrichedcognitivesearch$RANDOM --location swedencentral --resource-group $resourceGroupName --sku S1
printf "${GREEN}Setup completed. \n${NORMAL}"
