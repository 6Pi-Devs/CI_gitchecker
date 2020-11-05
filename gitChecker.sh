#!/bin/bash

###################
### GIT CHECKER ###
###################

### INFO ###
#https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git


### GIT ACTIONS ###
source lib/gitFunctions.sh

### GLOBAL ###
GIT_PATH="."
MINUTES=10
UPDATE_TIME=$(($MINUTES*60))







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
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
    else
        echo "Diverged"
    fi

}

### MAIN ###
main(){
    git_checker

}


### LOOP ###
while true
do
    main
    sleep $UPDATE_TIME
done

