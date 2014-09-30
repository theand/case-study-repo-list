
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
            echo "Processing : $DIR/"
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
    for DIR in *.txt;
    do
        bname=$(basename "$DIR" .txt);
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="
        if [[ -d ../$bname ]]
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
        echo "Processing : $DIR/"
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

    cd ../General-Case-Study/
    get_all_git_origin > ../case-study-repo-list/general_new.txt

    cd ../Java-Case-Study/
    get_all_git_origin > ../case-study-repo-list/java_new.txt

    cd ../JavaScript-Case-Study/
    get_all_git_origin > ../case-study-repo-list/javascript_new.txt

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

    cd ../Ruby-Case-Study/
    get_all_git_origin > ../case-study-repo-list/ruby_new.txt

    cd ../TutsPlus-Resources/
    get_all_git_origin > ../case-study-repo-list/tuts_new.txt

    cd ..

}
