#!/bin/bash

######################
###  GIT CHECKER   ###
### Auth: Yupipi93 ###
######################


### GLOBAL ###
BRANCH="main"
GIT_PATH="."
UPDATE_TIME=10 #in minutes

### IMPORT ###
source lib/gitFunctions.sh
source lib/getParameters.sh


git_checker(){

    git_fetch

    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
	echo "Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "Need to pull"
        source pullActions.sh
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
    else
        echo "Diverged"
    fi

}




### MAIN ###
main(){
    #git_checker $BRANCH
    echo $BRANCH
    echo $GIT_PATH
    echo $UPDATE_TIME
}


### LOOP ###
while true
do
    main
    sleep $(($UPDATE_TIME*60))
done

