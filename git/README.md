# Git

`sudo apt install git` and go to town.


Copy the `./gitconfig` to `~/.gitconfig` to get better log output. Be sure to update username and email.


## Things I Often Forget

### Remove local branches that aren't on remote

```bash
    git remote prune origin --dry-run
```
### Create a tagged branch

Create a tagged branch to version a program. Example 1.12.34. I like the versioning MAJOR.MINOR.PATCH. See this link
for more information: https://semver.org

This is useful for production deployments since instead of rolling back a branch (such a "main") you can just redeploy
the only version. Versions are a fixed point in the repo, so there is no merging or changing after the tag is created.

```bash
# this will get all the existing tags in case you don't have them locally
git fetch 
git checkout <branch>
git pull origin <branch>
# this will list tags 
git tag
# Create new tag and push
git tag vX.Y.Z-beta
git push origin vX.Y.Z-beta
```

### Cherry picking a branch and creating a new tag

Merge just a single commit to a branch. Useful for hotfixes, though I typically like to just branch off and create a
merge with changes. Seems less dangerous to me. 

```bash
git fetch
git checkout <most_recent_tag>
git cherry-pick <some_commit_hash>
git tag <new_tag>
git push origin <new_tag>
```


### Checkout Flatten Commits

This is used to flatten previous commits into one commit. For example, if you have a made a bunch of small changes to
get something right, but don't want it to appear that way in the git history. You can check out a previous commit, add
the change, make a new commit and then force that change.

```bash
git reset 3a3Bbe4
git add .
git commit -m 'some message'
git push --force
```

### Change previous commit messages

This is a pretty big pain, but worth knowing how to do. This is basically the same as flattening the commits except you
only checkout the previous

```bash
    # Get branch and update, check log
    git checkout <branch_name>
    git pull origin <branch_name>
    
    # Find commit to change, reset to hash, add all, new message, force push
    git log
    git reset <commit_hash> # you can also do 'git reset HEAD~n' where n is the number of commit messages you want to undo from the branch tip
    git add .  # if you want to break the changes up into a few small detailed commits you'll need to add the files one by one (you can use something like tig to do line by line adds)
    git commit -m "descriptive new name for WIP work done"
    git push origin <branch_name> -f
```

