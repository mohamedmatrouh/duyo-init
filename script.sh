
CASH_FOLDER=".cache"

saveFileHashToCache(){
    local fileName=$1
    sha1sum $fileName > $CASH_FOLDER/"$fileName.sha1"
}

loadFileHashFromCache(){
    local fileName=$1
    if [ -f $CASH_FOLDER/"$fileName.sha1" ]; then
        cat $CASH_FOLDER/"$fileName.sha1"
    fi
}


checkIfFilesHaveChanged() {

    local files="$@"
    local counter=0
    for fileName in "${files[@]}";
        do
            echo "checking $fileName.... "

            local oldHash=$(loadFileHashFromCache $fileName)
            local newHash=$(sha1sum $fileName)

            if [ "$oldHash" == "$newHash" ]; then
                echo "No changes detected for $fileName"
            else
                echo "Changes detected for $fileName"
                saveFileHashToCache $fileName
                ((counter = counter + 1))
            fi

        done
        
    if [ "$counter" == 0 ]; then
        exitFromTask 0
    else
        exitFromTask 1
    fi
}

exitFromTask() {
    if [ "$1" == 0 ]; then
        printf "true" | tee result
    else
        printf "false" | tee result
    fi
    
    exit 0;
}

checkIfFilesHaveChanged package.json package-lock.json