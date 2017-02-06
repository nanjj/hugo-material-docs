#!/usr/bin/env bats
@test "Make and Push" {
    eval `git log -n1 --pretty='author="%an <%ae>"'`
    hugo
    git reset --hard
    git checkout master
    git pull
    prefix="Travis build at "
    if git log --pretty=oneline -n 1 | grep "$prefix"; then
        skip
    fi
    make clean
    make
    if [ $(git status -s | wc -l) -gt 0 ]; then
        git commit -a --author="$author" -m "Travis build at $(date -Im)"
    fi
    if git status -bs | grep "\[ahead 1\]$"; then
        git push
    fi
}
