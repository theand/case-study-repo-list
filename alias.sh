
CASE_STUDY=( Admin-Case-Study
Angular-Case-Study
Atom-Case-Study
Bot-Case-Study
boxen
Chrome-Case-Study
CodeKata-Case-Study
Crawler-Case-Study
Django-Case-Study
Docker-Case-Study
Electron-Case-Study
Flask-Case-Study
FrontEnd-Case-Study
General-Case-Study
iOS-Case-Study
JS-Case-Study
Java-Case-Study
Laracast
Laravel-Case-Study
LetsCodeJavaScript-Lab
LetsCodeJavaScript-LessonLearned
Motion-Case-Study
My-Module-Work
My-Sample-Code
My-Study-Material
My-Translation-Work
NodeJS-Case-Study
PHP-Case-Study
Python-Case-Study
Rails-Case-Study
React-Case-Study
Ruby-Case-Study
Security-Case-Study
Sinatra-Case-Study
Spring-Case-Study
SpringGuides-Case-Study
StaticSite-Case-Study
TIL
TODOXXX-Case-Study
TutsPlus-Resources
Vagrant-Case-Study
Vue-Case-Study
Wiki-Case-Study
)

shuffle() {
   local i tmp size max rand

   # $RANDOM % (i+1) is biased because of the limited range of $RANDOM
   # Compensate by using a range which is a multiple of the array size.
   size=${#CASE_STUDY[*]}
   max=$(( 32768 / size * size ))

   for ((i=size-1; i>0; i--)); do
      while (( (rand=$RANDOM) >= max )); do :; done
      rand=$(( rand % (i+1) ))
      tmp=${CASE_STUDY[i]} CASE_STUDY[i]=${CASE_STUDY[rand]} CASE_STUDY[rand]=$tmp
   done
}

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
            if git pull -X theirs;
            then
                echo "pull succeeded";
            else
                echo "!!!git reset hard!!!";
                git reset --hard origin/HEAD;
            fi
            git remote prune origin;
            cd .. ;
        fi
    done
}

#서브디렉토리의 모든 git 저장소를 gc
function gc_git_all(){
    for DIR in `ls`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
            echo "Processing : $DIR"
            cd $DIR ;
            git gc;
            cd .. ;
        fi
    done
}


function works_update_all(){

    shuffle;

    for bname in ${CASE_STUDY[@]}; do
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="

        if [[ -d ~/Works/$bname ]] && [[ $bname != "TutsPlus-Resources" ]] && [[ $bname != "My-Module-Work" ]] && [[ $bname != "My-Sample-Code" ]] && [[ $bname != "My-Study-Material" ]] && [[ $bname != "boxen" ]] && [[ $bname != "iOS-Case-Study" ]]
        then
            cd ~/Works/$bname ;
            update_git_all ;
        fi
    done
}


function works_gc_all(){

    for bname in ${CASE_STUDY[@]}; do
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="

        if [[ -d ~/Works/$bname ]] && [[ $bname != "My-Module-Work" ]] && [[ $bname != "My-Sample-Code" ]] && [[ $bname != "My-Study-Material" ]] && [[ $bname != "boxen" ]] && [[ $bname != "iOS-Case-Study" ]]
        then
            cd ~/Works/$bname ;
            gc_git_all ;
        fi
    done
}
#################


function reset_git_origin(){
    if [[ -d .git ]]
    then
        git reset --hard origin/master
    fi
}

function check_not_git(){
  for DIR in `ls`;
  do
      if [[ ! -d $DIR/.git ]]
      then
          echo "not git : $DIR"
      fi
  done
}




################
function create_txt_for_all_casestudy(){

    for d in ${CASE_STUDY[@]}; do
        echo $d
        cd ~/Works/$d
        get_all_git_origin > ../case-study-repo-list/${d}_new.txt
    done

    cd ~/Works/case-study-repo-list
}


################
function clone_repo_for_all_casestudy(){

    for d in ${CASE_STUDY[@]}; do
        echo $d
        mkdir -p ~/Works/$d;
        cd ~/Works/$d;
        clone_repo_from_txt ../case-study-repo-list/${d}.txt
    done

    cd ~/Works
}



#참고 https://github.com/theand/git-open/blob/develop/git-open
function replace_opdev_to_cpdev(){
    for DIR in `ls`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
            cd $DIR ;

            giturl=$(git config --get remote.origin.url)
            if [ -z "$giturl" ]; then
                echo "remote.origin.url not set in $DIR."
                cd ..;
                continue
            fi

            echo "Processing $DIR";
            if grep -q github.daumkakao.com:OpDev <<<$giturl; then
                echo "  original remote.origin.url : $giturl"
                giturl=${giturl/:OpDev/:CpDev}
                git remote set-url origin $giturl
                echo "  changed remote.origin.url : $giturl"
            else
                echo "  !!! not github.daumkakao.com:OpDev !!! : $giturl"
            fi

            echo "";
            cd .. ;
        fi
    done
}
