### GIT ACTIONS ###
git_stage_changes(){
    comment=$1
    git -C $GIT_PATH add .
    git -C $GIT_PATH commit -a -m $comment &> /dev/null
}

git_checkout(){
    branch=$1
    git -C $GIT_PATH checkout $branch 
}

git_secure_checkout(){
    checkout_to=$1
    git_stage_changes "change_branch"
    git_checkout $checkout_to 
}

git_new_branch(){
    new_branch=$1
    git -C $GIT_PATH branch $new_branch
}

git_pull(){
    git -C $GIT_PATH config pull.rebase false
    git -C $GIT_PATH pull
}

git_secure_pull(){
    git_stage_changes "auto_commit"
    git_pull
}

git_force_pull(){
    branch_to_force_pull=$(git_current_branch_name)
    git_new_branch temp
    git_secure_checkout temp
    git_force_delete_local_branch $branch_to_force_pull
    git_secure_checkout $branch_to_force_pull
    git_force_delete_local_branch temp




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

git_force_delete_local_branch(){
    branch_to_delete=$1
    git -C $GIT_PATH branch -D $branch_to_delete
}

git_repo_name(){
    basename `git -C $GIT_PATH rev-parse --show-toplevel`
}

git_current_branch_name(){
    git -C $GIT_PATH branch --show-current
}

git_get_remote_info(){ 
    git -C $GIT_PATH fetch
}

git_get_local_revision(){
    git -C $GIT_PATH rev-parse @
}

git_get_remote_revision(){
    UPSTREAM=${1:-'@{u}'}
    git -C $GIT_PATH rev-parse "$UPSTREAM"
}

git_get_local_remote_compare(){
    UPSTREAM=${1:-'@{u}'}
    git -C $GIT_PATH merge-base @ "$UPSTREAM"
}


