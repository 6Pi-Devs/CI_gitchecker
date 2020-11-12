
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

git_merge_pull(){
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
    #Only avaible in git version 2.22
    #git -C $GIT_PATH branch --show-current
    git -C $GIT_PATH rev-parse --symbolic-full-name --abbrev-ref HEAD
}



### GET INFO AND COMPARE ###
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




### UPDATE METHODS ###
merge_update(){
    echo ""
    echo "METHOD: MERGE"
    git_merge_pull
}

force_update(){
    echo ""
    echo "METHOD: FORCE"
    git_force_pull
}


UPDATE_PROYECT(){
    if [ $MERGE_UPDATE_SELECTED ]; then
        merge_update
    else
        force_update
    fi

}




### GIT CONFIG ###
git_get_name(){
    git -C $GIT_PATH config user.name
}

git_set_name(){
    user_name=$1
    git -C $GIT_PATH config user.name $user_name
}

git_get_email(){
    git -C $GIT_PATH config user.email
}

git_set_email(){
    user_email=$1
    git -C $GIT_PATH config user.email $user_email
}

git_is_credentials_stored(){
    git -C $GIT_PATH config credential.helper
}

git_set_credentials(){
    git -C $GIT_PATH config credential.helper store
    git_fetch
}

git_remove_config(){
    #git -C $GIT_PATH credential-cache exit
    git -C $GIT_PATH config --unset user.name
    git -C $GIT_PATH config --unset user.email
    git -C $GIT_PATH config --unset credential.helper
}

git_show_config(){
    echo ""
    echo "[ USING CONFIG ]"
    echo "Name: $(git_get_name)"
    echo "Email: $(git_get_email)"
    echo "Credentials: $(git_is_credentials_stored)"
    echo "--> erase config with [-r] flag"
    echo ""
}

git_initial_config(){
    if [ ! $(git_get_name) ]; then
        read -p "Enter your name : " imput_name
        git_set_name $imput_name
    fi

    if [ ! $(git_get_email) ]; then
        read -p "Enter your email : " imput_email
        git_set_email $imput_email
    fi

    if [ ! $(git_is_credentials_stored) ]; then
        git_set_credentials
    fi


}





