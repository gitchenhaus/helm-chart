#!/bin/bash

# set -ex

main() {
    checkWorkspace

    helms=($(ls -d */))

    for helmName in "${helms[@]}"
    do
        echo "-------------------------------------------------------------------------------------------------------------------------"
        echo "${helmName} Test Started"
        if [[ $helmName != resources* ]]
        then
            helmFolder='./'${helmName::-1}
            echo "==>Start Lint:"${helmName::-1}
            echo "==>Command: helm lint $helmFolder"
            helm lint $helmFolder
            if [[ $? -ne 0 ]];
            then
                echo "Failure: Lint Fail.." >&2
                exit 1
            fi

            echo "==>Start Dry Run:"${helmName::-1}
            echo "==>Command: helm template --debug --generate-name $helmFolder"
            helm template --debug --generate-name $helmFolder

            if [[ $? -ne 0 ]];
            then
                echo "Dry Run Fail.." >&2
                exit 1
            fi

        else
            echo $helmName"=> No match"
        fi
    done

}

checkWorkspace() {
    PWD_PATH=`pwd`
    if [[ "${PWD_PATH}" == *"scripts"* ]]; then
        echo "script started on scripts Folder"
        echo "Back to root Folder..."
        cd ../../source-code/
    else
        echo "script started on other Folder"
        cd ./source-code/
    fi
}

main "$@"
