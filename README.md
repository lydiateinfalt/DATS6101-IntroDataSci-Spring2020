# DATS6101-Spring2020-IntroDataSci

This repo contains a collection of Izzy Illari's work for DATS 6101 Spring 2020 at GWU. You may contact me at izzy@jlab.org or iti2103@gwu.edu for more info.

Also included is the work on the class project with fellow teammates Lucia Illari (loi2102@gwu.edu), Lydia Teinfalt (lteinfalt@gwu.edu), Omar Qusous (oqusous@gwu.edu), and Obumneke Amadi (obumneke_amadi2@gwu.edu).

To see a live version of the final project write up please go here [here](https://userweb.jlab.org/~izzy/DATS6101_Spring2020/proj1_template.html).

Clone repo
-----------

To clone this repo, you may use GitHub Desktop, or terminal. If using terminal, the following command will clone this repository: 

```git clone https://github.com/IzzyIllari/DATS6101-Spring2020-IntroDataSci.git```

This will create a directory called "DATS6101-Spring2020-IntroDataSci". Inside that directory, you will find all my files and folders. 

Keep repo up-to-date
--------------------

If the repo is newer than your local version, you can't push your changes, and you will receive a log telling you to merge. You can use the following command to saty up to date:

`git pull`

Note: This will open an editor with a merge message, which you don't need to edit (just exit the editor).

Add/remove a file to repo
--------------------------

Use `add` to add files to the repo:

`git add filename`

or `rm` to remove files from the repo:

`git rm filename`

When checking the status with `git pull` there will be an `A` for "added" files and a `D` for "deleted" files.


Commit changes to repo
----------------------

Check which files you have changed with the following command:

`git status`

To commit changes to a particular file, don't forget:

`git commit filename -m"nice comment"`

To commit changes to all the files use the `-a` flag:

`git commit -a -m"nice comment"`

Push to repo
-------------

To push to the repository use the following command:

`git push`

This will upload your changes.
