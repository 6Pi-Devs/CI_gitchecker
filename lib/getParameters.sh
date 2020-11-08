Help(){

    echo "gitChecker detect updates in you repository and apply you select actions in the project"
    echo
    echo "Syntax: ./gitChecker.sh [OPTIONS]"
    echo "OPTIONS:"
    echo "-b 'branch'   Branc name to check updates.        [DEFAULT:current]"
    echo "-p 'path'     Path of repository folder.          [DEFAULT:..]"
    echo "-u 'update'   Update time in minutes.             [DEFAULT:10]"
    echo "-f            Force update. Discards local files. [DEFAULT:merge]"
    echo "-r            Remove config (name,email,credentials)"
    echo "-h            Print this Help."
    echo
    exit 0
}



### GET PARAMETERS ###
while getopts "b:p:u:frh" options;
do
    case $options in
        b) BRANCH=${OPTARG};;
        p) GIT_PATH=${OPTARG};;
        u) UPDATE_TIME=${OPTARG};;
        f) FORCE_UPDATE_SELECTED=1;;
        r) git_remove_config;;
        h) Help;;
    esac
done
