#!/bin/bash

# set -ex

main() {
    helms=($(ls -d ./helmValue/*/*))

    for helmName in "${helms[@]}"
    do
     if [[ $helmName != *cdn.yml ]]
    then
        echo "-------------------------------------------------------------------------------------------------------------------------"
        echo "${helmName} Test Started"

        # helmFolder='./'${helmName::-1}
        # echo "==>Start Lint:"${helmName::-1}
        # echo "==>Command: helm lint $helmFolder"
        # helm lint $helmFolder
        # if [[ $? -ne 0 ]];
        # then
        #     echo "Failure: Lint Fail.." >&2
        #     exit 1
        # fi      
        # echo "==>Start Dry Run:"${helmName::-1}
        # echo "==>Command: helm template --debug --generate-name $helmFolder"
        helm template -f $helmName --generate-name ./application-template      
        if [[ $? -ne 0 ]];
        then
            echo "Dry Run Fail.." >&2
            exit 1
        fi
    fi

    done

}

main "$@"
