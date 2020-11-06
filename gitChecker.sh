#!/bin/bash

######################
###  GIT CHECKER   ###
### Auth: Yupipi93 ###
######################


### GLOBAL ###
BRANCH="main"
GIT_PATH=".."
UPDATE_TIME=10 #in minutes

### IMPORT ###
source lib/gitFunctions.sh
source lib/getParameters.sh


git_checker(){

    echo "Target repository: $(git_repo_name)"
    echo "           Branch: $(git_branch_name)"
    echo "Geting info..."     
    git_fetch

    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
	echo "--> Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "--> Need to pull"
        source pullActions.sh
    elif [ $REMOTE = $BASE ]; then
        echo "--> Need to push"
    else
        echo "--> Diverged"
    fi

}


next_update(){
    sleep 2
    echo " "
    echo "Next update in $UPDATE_TIME minute/s"
    sleep $(($UPDATE_TIME*60))
    echo " "
}


### MAIN ###
main(){
    while true
    do
        git_checker $BRANCH
        next_update
    done
}



### START ###
main

