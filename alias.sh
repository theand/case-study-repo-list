
#################

#서브디렉토리들의 git remote 저장소 주소를 뽑아내기.
function get_all_git_origin(){
    for DIR in `ls`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
           cd $DIR ;
           git config --get remote.origin.url ;
           cd .. ;
        fi
    done
}

#지정한 디렉토리 목록에 대해서만 저장소 주소를 뽑아냄
function get_git_origin_from_txt(){
    while read line;
    do
        if [[ -d $line ]]
        then
            cd $line ;
            git config --get remote.origin.url ;
            cd ..;
        fi
    done < $1
}


#git 저장소 경로를 담고 있는 txt파일을 읽어서 프로젝트를 모두 clone.
function clone_repo_from_txt(){
    while read line;
    do
        git clone $line ;
    done < $1
}

#################

#서브디렉토리의 모든 git 저장소를 업데이트.
function update_git_all(){
    for DIR in `ls`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
            echo "Processing : $DIR"
            cd $DIR ;
            if git pull ;
            then
                echo "pull succeeded";
            else
                echo "!!!git reset hard!!!";
                git reset --hard origin/master;
            fi
            cd .. ;
        fi
    done
}


function works_update_all(){
    cd ~/Works/case-study-repo-list;
    for DIR in *-*.txt;
    do
        bname=$(basename "$DIR" .txt);
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="

        if [[ -d ../$bname ]] && [[ $bname != "TutsPlus-Resources" ]] 
        then
            cd ../$bname ;
            update_git_all ;
            cd ../case-study-repo-list;
        fi
    done
}

#################

function update_composer_all(){
    for DIR in `ls`;
    do
        echo "Processing : $DIR"
        if [[ -d $DIR ]] && [[ -e $DIR/composer.json ]]
        then
            cd $DIR ;
            composer update ;
            cd .. ;
        fi
    done
}


function reset_git_origin(){
    if [[ -d .git ]]
    then
        git reset --hard origin/master
    fi
}



################
function create_txt_for_all_casestudy(){

    cd ~/Works

    cd Angular-Case-Study/
    get_all_git_origin > ../case-study-repo-list/angular_new.txt

    cd ../FrontEnd-Case-Study/
    get_all_git_origin > ../case-study-repo-list/front_new.txt

    cd ../General-Case-Study/
    get_all_git_origin > ../case-study-repo-list/general_new.txt

    cd ../Java-Case-Study/
    get_all_git_origin > ../case-study-repo-list/java_new.txt

    cd ../SpringGuides-Case-Study/
    get_all_git_origin > ../case-study-repo-list/spring_new.txt

    cd ../JS-Case-Study/
    get_all_git_origin > ../case-study-repo-list/js_new.txt

    cd ../Electron-Case-Study/
    get_all_git_origin > ../case-study-repo-list/electron_new.txt

    cd ../NodeJS-Case-Study/
    get_all_git_origin > ../case-study-repo-list/nodejs_new.txt

    cd ../Laracast/
    get_all_git_origin > ../case-study-repo-list/laracast_new.txt

    cd ../Laravel-Case-Study/
    get_all_git_origin > ../case-study-repo-list/laravel_new.txt

    cd ../LetsCodeJavaScript-Lab/
    get_all_git_origin > ../case-study-repo-list/lets_lab_new.txt

    cd ../LetsCodeJavaScript-LessonLearned/
    get_all_git_origin > ../case-study-repo-list/lets_lesson_new.txt

    cd ../My-Study-Material/
    get_all_git_origin > ../case-study-repo-list/study_new.txt

    cd ../My-Translation-Work/
    get_all_git_origin > ../case-study-repo-list/trans_new.txt

    cd ../PHP-Case-Study/
    get_all_git_origin > ../case-study-repo-list/php_new.txt

    cd ../Python-Case-Study/
    get_all_git_origin > ../case-study-repo-list/python_new.txt

    cd ../Ruby-Case-Study/
    get_all_git_origin > ../case-study-repo-list/ruby_new.txt

    cd ../Rails-Case-Study/
    get_all_git_origin > ../case-study-repo-list/rails_new.txt

    cd ../TutsPlus-Resources/
    get_all_git_origin > ../case-study-repo-list/tuts_new.txt

    cd ..

}




################
function clone_repo_for_all_casestudy(){

    cd ~/Works

    cd Angular-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Angular-Case-Study.txt

    cd ../FrontEnd-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/FrontEnd-Case-Study.txt

    cd ../General-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/General-Case-Study.txt

    cd ../Java-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Java-Case-Study.txt

    cd ../SpringGuides-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/SpringGuides-Case-Study.txt

    cd ../JS-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/JS-Case-Study.txt

    cd ../NodeJS-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/NodeJS-Case-Study.txt

    cd ../Electron-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Electron-Case-Study.txt

    cd ../Laracast/
    clone_repo_from_txt ../case-study-repo-list/Laracast.txt

    cd ../Laravel-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Laravel-Case-Study.txt

    cd ../LetsCodeJavaScript-Lab/
    clone_repo_from_txt ../case-study-repo-list/LetsCodeJavaScript-Lab.txt

    cd ../LetsCodeJavaScript-LessonLearned/
    clone_repo_from_txt ../case-study-repo-list/LetsCodeJavaScript-LessonLearned.txt

    cd ../My-Study-Material/
    clone_repo_from_txt ../case-study-repo-list/My-Study-Material.txt

    cd ../My-Translation-Work/
    clone_repo_from_txt ../case-study-repo-list/My-Translation-Work.txt

    cd ../PHP-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/PHP-Case-Study.txt

    cd ../Ruby-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Ruby-Case-Study.txt

    cd ../Rails-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Rails-Case-Study.txt

    cd ../Python-Case-Study/
    clone_repo_from_txt ../case-study-repo-list/Python-Case-Study.txt

    cd ../TutsPlus-Resources/
    clone_repo_from_txt ../case-study-repo-list/TutsPlus-Resources.txt

    cd ..

}
