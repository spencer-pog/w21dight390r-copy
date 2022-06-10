# Intro to bash

In different contexts, the following terms can all refer to the same thing:

* Command Line Interface (CLI)
* Terminal
* Shell
  * Bash (Bourne-Again SHell)  <-- most popular
  * ksh, zsh, etc.
* REPL (Read Evaluate Print Loop)
  * This can refer to any interactive session, including python, etc.

To access `bash`, just open a Terminal app. By default, most Terminals are
configured to use `bash` by default, but recently MacOS switched to `zsh`. They
are both POSIX-compliant, so the differences are not all that important. If you
want, you can run `bash` inside of `zsh`, or vice versa.

When you first open your terminal, it automatically "sources" the hidden file
in your home directory `~/.profile`. (`~` is a shortcut for your home directory
`/home/<username>/` or `/Users/<username>`. In Linux/MacOS, any file that that
start with `.` is a hidden file.) One important thing that this file does is to
define where `bash` will look for executable files, i.e. the `PATH` variable.

## Navigation

* `pwd` (Present Working Directory) shows you your current location.
* `ls` (LiSt contents) shows the files and directories in the specified
  directory (default: current directory)
  * `ls -l` gives the long form with permissions, file size, last modified, etc.
* `cd` (Change Directory) moves to the specified directory (default: home directory)
  * `.` refers to the current directory
  * `..` refers to the parent directory, so `cd ..` moves to the parent
    directory.
* `mkdir` (MaKe a DIRectory" creates a new directory.
* `rm` (ReMove) deletes files and directories (BEWARE: cannot be undone!)
  * to remove a directory, you must use the `-r` flag (recursive): `$ rm -r this_dir`

> Note that modern shells are great at autocompleting when you've already given
> enough information. For example, if there are two directories named
> `reynolds1` and `reynolds2` in the current directory, I can just type
> `cd rey` and then hit the <kbd>Tab</kbd> button, and `bash` will autocomplete
> `reynolds`, and then I just have to type `1` or `2`. Train yourself to use
> <kbd>Tab</kbd> often! It avoids typos and is much faster!

### Navigation practice

`cd` into your the `/tmp/` directory and create a tree of directories that
represents your family tree. Start by making a directory with one of your
grandparents' names, then `cd` into that directory, and make a new directory
for at least two of their children. Continue until you feel comfortable
navigating.  Move around your file system using `pwd`, `ls`, and `cd` (and
[tab]!) until all of them are automatic.

## Redirecting `stdout` and `stderr`

When `pwd` and `ls` print to the screen, they are using a channel/stream called
`stdout` (standard out). When programs want to give information to the user
that is not strictly the "output" of the program, they use a channel/stream
called `stderr`. You can redirect a process' `stdout` and `stderr` in a variety
of ways.

* `>` redirects `stdout` to a file (overwrites if the file already exists)
  * `$ ls > directory_contents.txt`
* `2>` redirects `stderr` to a file (overwrites if the file already exists)
  * `$ rm file_that_does_not_exist.txt 2> error_msg.txt`
  * This is frequently used to hide `stderr` from the terminal, by sending it
    to a special file `/dev/null`, which is essentially a black hole.
* `>>` appends `stdout` to a file
  * `$ ls >> directory_contents.txt`
* `|` "pipes" the `stdout` from one process to the `stdin` of the next process
  * `$ ls | rev` pipes the output of `ls` into the input of `rev` (reverse)
* `2|` "pipes" the `stderr` from one process to the `stdin` of the next process
  * (Too rare to give a useful example)
* `echo` Send the specified string (followed by a newline) to `stdout`
  * `$ echo "hello world!"` (writes `hello world!` to the screen)
  * `$ echo "hello world!" > file1.txt`
* `cat` (conCATenate) Read the contents of file(s) to `stdout`
  * `$ cat file1.txt` (writes the contents of `file1.txt` to the terminal screen (`stdout`)
  * `$ cat file1.txt file2.txt file3.txt > all_files.txt`

### Redirecting practice

1. Make a file called `password.txt` that contains the string `- Open sesame!`
1. Add another line to `password.txt` that says `- Wrong password. Please try again.`
1. Display the contents of `password.txt` to the terminal.
1. Make a file called `name.txt` that has your name in it
1. Make a file called `this_dir.txt` that contains the path of the current directory.
1. Make a file called `all_three.txt` that combines the contents of the three previous files into one.

## Using `less` to read files in the command line

The most "user-friendly" way to read files in the terminal is using `less`.
Just type `$ less filename`.

* `q` close/exit (This is a very common way to close command line utilities.)
* `j` down one line (arrow keys work, too)
* `k` up one line (arrow keys work, too)
* `f` "forward/down" one page
* `b` "back/up" one page

Searching in `less` requires just three keys.

* `/` opens the prompt to enter your search string (accepts regular expressions)
  * Type your search string or regular expression, then hit <kbd>enter</kbd>.
  * `n` takes you to the next hit.
  * `N` takes you to the previous hit.

> Note that the `man` command uses `less` to open the "help manual" for any
> command.

### `less` practice

1. Use `less` to read your `~/.profile` file. Search for `PATH` to see if your
   profile is adding any custom locations for executables.
1. Read the contents of `/usr/local/bin/` (pipe output of `ls` into `less`)
   * Search for executable files that contain the string `hfst`
   * Search for executable files that contain the string `cg`
1. Look up the help manual for the `less` command.
   * Search for `DESCRIPTION` and read the first paragraph.
   * Find what the `-N` flag does.

## Filter with `grep` (Gnu Regular Expression Pattern)

You can filter a channel/stream/file by lines that match basic regular
expressions using `grep`. The two main usages are `$ grep <pattern> <filename>`
and `$ some_command | grep <pattern>`.

You can use the `-v` flag to return lines that DO NOT match the pattern:
`$ grep -v <pattern> filename` or `$ some_command | grep -v <pattern>`.

### `grep` practice

1. Search `password.txt` (you created it earlier) for lines with the string `me`
1. Use `grep` with `ls` to list files in `/usr/local/bin/` that contain `hfst`
1. Use `grep` with `ls` to list files in `/usr/local/bin/` that contain `visl`
1. Use `grep` with `ls` to list files in `/usr/local/bin/` that do NOT contain
   `hfst`, but DO contain the letter `s` and read the output with `less`.

## Other useful commands

Use `man` to explore these other useful commands

* `rev`
* `sort`
* `uniq`
* `cut`
