#!/bin/bash

###################
### GIT CHECKER ###
###################

### GLOBAL ###

GIT_PATH="."


### GIT ACTIONS ###

#git_secure_push "branch"
git_secure_push(){
    branch_to_push = $1
    #commit actual branch
    git -C $GIT_PATH add .
    git -C $GIT_PATH commit -a -m "auto-commit"
    #change and update backup branch
    git -C $GIT_PATH checkout $branch_to_push
    git -C $GIT_PATH pull
    #create commit
    git -C $GIT_PATH add .
    git -C $GIT_PATH commit -a -m "auto_push"
    #push autosave
    git -C $GIT_PATH push
    #change to master
    git -C $GIT_PATH checkout master
    echo "Secure-Push-Alredy"

}



git_checker(){
    echo $1
    git fetch

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
   #git_checker "Hello"
   git_secure_push "main"

}
main

