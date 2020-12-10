#!/bin/bash
#https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
######################
###  GIT CHECKER   ###
### Auth: Yupipi93 ###
######################


### ENVIRONMENTS ###
ENV_PATH="CI_gitchecker/"

### GLOBAL ###
BRANCH=
GIT_PATH="."
UPDATE_TIME=10 #in minutes
MERGE_UPDATE_SELECTED=


import(){
    file_path=$1
    source "$ENV_PATH$file_path"
}


### IMPORT ###
source $ENV_PATH"lib/gitFunctions.sh"
source $ENV_PATH"lib/getParameters.sh"



update_actions(){
    echo ""
    echo "STOP ACTIONS"
    import stopActions.sh
    echo "UPDATING PROJECT"
    UPDATE_PROYECT
    echo "START ACTIONS"
    import startActions.sh
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

set_selected_branch(){
    set_branch=$1
    if [ $set_branch ]; then
        echo "Change to branch: $set_branch"
        git_secure_checkout $set_branch
    fi

}


### MAIN ###
main(){
    echo "START ACTIONS"
    import startActions.sh
    while true
    do
        git_initial_config
        git_show_config

        set_selected_branch $BRANCH
        git_checker $BRANCH

        next_update
    done
}



### START ###
main

