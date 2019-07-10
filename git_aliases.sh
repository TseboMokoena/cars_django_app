alias currentbranch='git rev-parse --abbrev-ref HEAD'
f_setup() {
    git branch master --quiet --set-upstream-to origin/master
    git config branch.autosetuprebase always
    git config branch.master.rebase true
    git config branch.$(currentbranch).rebase true
}
alias setup=f_setup
alias pull='setup && git pull --rebase origin $(currentbranch)'
alias push='setup && git push origin $(currentbranch)'
f_merge() {
    if [ $1 ]
    then
        thatbranch=$1
        thisbranch=$(currentbranch)
        git merge --no-ff -m "Merging $thatbranch into $thisbranch [$2]" $thatbranch
    else
        echo 'Merging from other branch to current branch'
        echo '-----------------------------------------'
        echo 'Usage: merge <other_branch> [commit_msg]'
    fi
}
alias merge=f_merge
f_createbranch() {
    if [ $1 ]
    then
        newbranch=$1
        git checkout -b $newbranch
        setup
    else
        echo 'Creates a feature branch from the current one'
        echo '-----------------------------------------'
        echo 'Usage: createbranch <new_branch>'
    fi
}
alias createbranch=f_createbranch