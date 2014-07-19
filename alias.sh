function get_all_git_repo(){
    for DIR in *;
    do
        [[ -d $DIR ]] && [[ -d $DIR/.git ]] && cd $DIR && git config --get remote.origin.url && cd .. ;
    done
}

function update_git_all(){
    for DIR in *; 
    do
        echo "Processing : $DIR/"
        [[ -d $DIR ]] && [[ -d $DIR/.git ]] && cd $DIR && git pull && cd .. ; 
    done
}

function works_update_all(){
    pushd .
    cd ~/Works/Angular-Case-Study;
    update_git_all;
    cd ~/Works/My-Study-Material;
    update_git_all;
    cd ~/Works/Laravel-Case-Study;
    update_git_all;
    popd
}

function update_composer_all(){
    for DIR in *; 
    do
        echo "Processing : $DIR/"
        [[ -d $DIR ]] && [[ -e $DIR/composer.json ]]  && cd $DIR && composer update && cd .. ; 
    done
}

