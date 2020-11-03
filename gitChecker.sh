#!/bin/bash

###################
### GIT CHECKER ###
###################

### GLOBAL ###

GIT_PATH="."


### GIT ACTIONS ###
git_stage_changes(){
    comment=$1
    git -C $GIT_PATH add .
    git -C $GIT_PATH commit -a -m $comment
}

git_checkout(){
    branch=$1
    git -C $GIT_PATH checkout $branch
}

git_pull(){
    git -C $GIT_PATH pull
}

git_push(){
    git -C $GIT_PATH push
}

git_secure_push(){
    git_stage_changes "auto_commit"
    git_pull
    git_stage_changes "auto_commit"
    git_push
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

