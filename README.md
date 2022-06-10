# W21\_DIGHT390R

Resources for DIGHT 390R: NLP for low-resource languages

## Points of communication

* [Slack](https://reynoldsnlp.slack.com)
  * Virtually all communication about the course will happen here
  * In order to receive notifications, I highly recommend that you download the
    desktop/phone apps
* [Github](https://github.com/reynoldsnlp/W21_DIGHT390R) (this page)
  * Lecture notes and other course materials will distributed here
  * If you are not familiar with `git`, the
    [Github Desktop](https://desktop.github.com/) app is among the easiest ways
    to interact with git servers.
* [Learning Suite](https://learningsuite.byu.edu)
  * Course assignments / grading
  * Schedule of topics
  * Zoom links and recordings

## General resources

* HFST: https://github.com/hfst/hfst/wiki
* VISLCG3: https://visl.sdu.dk/cg3.html
* GiellaLT: https://giellalt.uit.no/
  * Migrating to github pages? (https://giellalt.github.io/)

## Setup

### Operating Systems

This course assumes that you are using MacOS or Linux (or really any other
\*nix OS). If you are trying to choose between possible Linux distros, please
use Ubuntu or another Debian-based distro.

It is possible to perform all of the functions of the course in Windows, but it
is more difficult and I do not have the expertise to help you.  If you have
Windows, I highly recommend that you [set up dual
boot](https://itsfoss.com/install-ubuntu-1404-dual-boot-mode-windows-8-81-uefi/)
or [install the Windows Linux
Subsystem](https://docs.microsoft.com/en-us/windows/wsl/install-win10#manual-installation-steps).
If you have questions, please ask on `Slack`.

### Text editor

As with any coding project, you will use a text editor to edit files. I
recommend using [VSCode](https://code.visualstudio.com/), but you are welcome
to use another editor if you prefer. I would discourage the use of any text
editors that also do Rich Text Formatting, such as `TextEdit` (included with
MacOS).

If you are feeling adventurous, you could also learn to use `vim`, which is a
text editor that runs right in the command line terminal. It is a steep
learning curve, but once you get used to it, it is an extremely efficient
coding experience. Just open a Terminal and run `vimtutor` to get a basic
introduction.

### Install dependencies

Our course will focus on the use of Helsinki Finite-State Tools (HFST) and
VISL-Constraint Grammar 3 (VISL-CG3). The easiest way to install them and other
dependencies is to follow the instructions for your operating system, as listed
in Step 1 here: https://giellalt.uit.no/infra/GettingStarted.html

Follow the instructions as far as installing the linguistic software (HFST and
VISL-CG3) and then stop. The Xerox tools (XFST) are optional, since HFST can do
everything that XFST can and more. However, XFST does compile faster than HFST,
so it can be nice to have installed for rapidly compiling and testing
incremental changes to your work. Ignore the part about installing
`SubEthaEdit`; we will not use that text editor.
