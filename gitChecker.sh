#!/bin/bash
#https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
######################
###  GIT CHECKER   ###
### Auth: Yupipi93 ###
######################


### GLOBAL ###
BRANCH=
GIT_PATH=".."
UPDATE_TIME=10 #in minutes

### IMPORT ###
source lib/gitFunctions.sh
source lib/getParameters.sh


update_actions(){
        echo ""
        sleep 2
        echo "UPDATING PROYECT"
        source pullActions.sh
}

git_checker(){
    REMOTE_BRANCH=$1
    echo "Target repository: $(git_repo_name)"
    echo "           Branch: $(git_current_branch_name)"
    echo "Geting info..."     
    git_get_remote_info

    LOCAL=$(git_get_local_revision)
    REMOTE=$(git_get_remote_revision $REMOTE_BRANCH)
    BASE=$(git_get_local_remote_compare $REMOTE_BRANCH)

    if [ $LOCAL = $REMOTE ]; then
	    echo "--> Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "--> Need to pull"
        update_actions
    elif [ $REMOTE = $BASE ]; then
        echo "--> Need to push"
    else
        echo "--> Diverged"
        update_actions
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
        if [ $BRANCH ]; then
            echo "Change to branch: $BRANCH"
            git_secure_checkout $BRANCH
        fi
        git_checker $BRANCH
        next_update
    done
}



### START ###
main

