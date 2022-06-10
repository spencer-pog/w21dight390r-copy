# Introduction to GiellaLT

## MacOS: set terminal to `bash` instead of `zsh`

You can run the following command on MacOS to change your default terminal
shell to `bash`:

```bash
$ chsh -s /bin/bash
```

## GiellaLT

See lecture notes from [this excellent
presentation](https://giellalt.uit.no/presentations/MLLanguageTechnology.html)
prepared by Jack Reuter and Sjur Moshagen, both of the University of Helsinki.

## Compiling a transducer from `lexc`

Copy and paste the following `lexc` code and save it as `first.lexc`. Be sure
that you understand every part of the syntax of this example.

```
Multichar_Symbols
+V +Pres +3Sg +PresPtc +Past

! Lexicon containing lexical stems:
LEXICON Root
 walk V ;
 talk V ;
 pack V ;

! Lexicon containing POS tag only:
LEXICON V
+V: V-suff ;

! Lexicon containing inflectional suffixes and corresponding tags:
LEXICON V-suff
+Pres+3Sg:s   # ;
+Past:ed  # ;
+PresPtc:ing # ;
+Pres:    # ;
```

In order to compile a transducer from a `lexc` file, simply run one of the
following commands. They are all equivalent; just different ways of achieving
the same result. Note that by convention, compiled transducers have the `.hfst`
file extension.

```bash
$ hfst-lexc -o first_generator.hfst first.lexc 
$ hfst-lexc first.lexc > first_generator.hfst
$ cat first.lexc | hfst-lexc > first_generator.hfst
$ cat first.lexc | hfst-lexc -o first_generator.hfst
```

## Look up words in a compiled transducer

Once you have compiled a transducer, you can test it out using the
`hfst-lookup` command. For example, assuming that the previous compilation was
successful, the following command will send a string to be analyzed by the
compiled transducer. Our transducer is a generator, so the string that we give
should be a lemma and tags.

```bash
$ echo teach+V+Past | hfst-lookup first_generator.hfst
```
