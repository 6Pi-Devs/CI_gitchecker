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

git_get_remote_info(){ 
    git -C $GIT_PATH fetch
}

git_pull(){
    git -C $GIT_PATH pull
}

git_secure_pull(){
    git_stage_changes "auto_commit"
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

git_repo_name(){
    basename `git -C $GIT_PATH rev-parse --show-toplevel`
}

git_branch_name(){
    git -C $GIT_PATH branch
}

