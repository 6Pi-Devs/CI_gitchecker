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
    git -C $GIT_PATH pull --rebase
}

git_push(){
    git -C $GIT_PATH push
}

git_fetch(){ 
    git -C $GIT_PATH fetch
}

git_secure_push(){
    git_stage_changes "auto_commit"
    git_pull
    git_stage_changes "auto_commit"
    git_push
}
