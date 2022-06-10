# Basic transducer operations

Finite-state transducers are mathematically elegant.

* Mathematically elegant (closure properties)
  * can be combined together in powerful ways.
* Easily modified and reused
* They can scale up to huge sizes
* Computationally efficient. Very compact.
* Declarative programming -> language model (NOT ad hoc coding)
* Bidirectional: can analyze or generate

## `hfst-lexc`

To compile a transducer from a `lexc` file, we use `hfst-lexc`:

```
$ hfst-lexc -i first.lexc -o first_gen.hfst
```

## `hfst-lookup`

`hfst-lookup` is used to "transduce" one from from another. If the transducer
is a generator, then giving it a lemma and tags will output a surface form. If
the transducer is an analyzer, then giving it a surface form will output a
lemma and grammatical tags.

You may have noticed that `hfst-lookup` prints us a little message and prompts
(`>`) when we try to use it on a default transducer:

```
$ echo teach+V+Past | hfst-lookup first_gen.hfst
hfst-lookup: warning: It is not possible to perform fast lookups with OpenFST, std arc, tropical semiring format automata.
Using HFST basic transducer format and performing slow lookups
> teach+V+Past	taught	0.000000
```

There are two ways to suppress these:

```
$ echo teach+V+Past | hfst-lookup first_gen.hfst 2> /dev/null
$ echo teach+V+Past | hfst-lookup -q first_gen.hfst
```

The first sends everything from `stderr` to the black hole `/dev/null`. All
that is left, then is the `stdout` stream, which is the analysis itself.  The
second method takes advantage of the fact that `hfst-lookup` has a `-q` flag
that blocks printing anything on `stderr`.

## `hfst-fst2fst`

In order to make an FST that is capable of doing "optimized lookup", we use the
`hfst-fst2fst` command, which is used to convert between FST formats. All of
the following approaches are equivalent. Every possible permutation is listed
to help you understand how `bash` reads arguments:

```
$ cat first_gen.hfst | hfst-fst2fst -O -o first_gen.hfstol
$ cat first_gen.hfst | hfst-fst2fst -o first_gen.hfstol -O 
$ cat first_gen.hfst | hfst-fst2fst --optimized-lookup-unweighted -o first_gen.hfstol
$ cat first_gen.hfst | hfst-fst2fst -o first_gen.hfstol --optimized-lookup-unweighted 
$ cat first_gen.hfst | hfst-fst2fst -O > first_gen.hfstol
$ cat first_gen.hfst | hfst-fst2fst --optimized-lookup-unweighted > first_gen.hfstol
$ hfst-fst2fst -O -i first_gen.hfst > first_gen.hfstol
$ hfst-fst2fst -i first_gen.hfst -O > first_gen.hfstol
$ hfst-fst2fst --optimized-lookup-unweighted -i first_gen.hfst > first_gen.hfstol
$ hfst-fst2fst -i first_gen.hfst --optimized-lookup-unweighted > first_gen.hfstol
$ hfst-fst2fst -O -i first_gen.hfst -o first_gen.hfstol
$ hfst-fst2fst -O -o first_gen.hfstol -i first_gen.hfst 
$ hfst-fst2fst -o first_gen.hfstol -i first_gen.hfst -O 
$ hfst-fst2fst -o first_gen.hfstol -O -i first_gen.hfst
$ hfst-fst2fst -i first_gen.hfst -o first_gen.hfstol -O 
$ hfst-fst2fst -i first_gen.hfst -O -o first_gen.hfstol 
$ hfst-fst2fst --optimized-lookup-unweighted -i first_gen.hfst -o first_gen.hfstol
$ hfst-fst2fst --optimized-lookup-unweighted -o first_gen.hfstol -i first_gen.hfst 
$ hfst-fst2fst -i first_gen.hfst -o first_gen.hfstol --optimized-lookup-unweighted 
$ hfst-fst2fst -i first_gen.hfst --optimized-lookup-unweighted -o first_gen.hfstol 
$ hfst-fst2fst  -o first_gen.hfstol --optimized-lookup-unweighted -i first_gen.hfst
$ hfst-fst2fst  -o first_gen.hfstol -i first_gen.hfst --optimized-lookup-unweighted 
```

Make sure that you understand why all of the above commands are equivalent.
Hereafter, I will only give one example, and you can infer other ways that
you can call the same command. Remember that all flags are defined by the
command itself.

## `hfst-fst2strings`

In order to spell out every possible analysis that an FST contains, we can use
the `hfst-fst2strings` command.

```
$ hfst-fst2strings first_gen.hfst
walk+V+Past:walked
walk+V+PresPtc:walking
walk+V+Pres+3Sg:walks
walk+V+Pres:walk
talk+V+Past:talked
talk+V+PresPtc:talking
talk+V+Pres+3Sg:talks
talk+V+Pres:talk
teach+V+Past:taught
teach+V+Pres:teach
teach+V+Pres+3Sg:teaches
pack+V+Past:packed
pack+V+PresPtc:packing
pack+V+Pres+3Sg:packs
pack+V+Pres:pack
```

## `hfst-invert`

In order to invert an FST (for example, to change an analyzer into a generator,
and vice versa), we use `hfst-invert`:

```
$ hfst-invert -i first_gen.hfst -o first_ana.hfst
$ hfst-fst2strings first_ana.hfst
walked:walk+V+Past
walking:walk+V+PresPtc
walks:walk+V+Pres+3Sg
walk:walk+V+Pres
talked:talk+V+Past
talking:talk+V+PresPtc
talks:talk+V+Pres+3Sg
talk:talk+V+Pres
taught:teach+V+Past
teach:teach+V+Pres
teaches:teach+V+Pres+3Sg
packed:pack+V+Past
packing:pack+V+PresPtc
packs:pack+V+Pres+3Sg
pack:pack+V+Pres
```

## Looking up other tools

In the `bash` shell if you type `hfst-` and then hit <kbd>Tab</kbd> twice, you
will see an entire list of all the `hfst` commands. We will not cover all of
them in this class, but it is good to know how to explore these commands on
your own. There are two main ways to do this.

First, all of the `hfst` tools have a `--help` flag implemented, so for example,
the following command will print limited help documentation for `hfst-disjunct` to the terminal:

```
$ hfst-disjunct --help
```

Second, you can use the `man` command to look up the help documentation inside
of `less`. (Remember the keys, `f`, `b`, `/`, `n`, `N`, `q`, etc.)

```
$ man hfst-disjunct
```

### Practice

1. Write a very simple lexc file similar to `first.lexc`, but include only
   nouns.  Then, compile it, combine it with `first_gen.hfst` using
   `hfst-disjunct`, and convert the resulting FST to optimized lookup format.
1. Look up the help docs for `hfst-reverse`. Use it to "reverse"
   `first_gen.hfst` and save the resulting FST as `first_gen_rev.hfst`. Print
   all possible analyses of `first_gen_rev.hfst` to the terminal. Look at the
   result to determine how `hfst-reverse` is different from `hfst-invert`.
1. Look at the documentation for `hfst-substitute`. Figure out how to convert
   all of the surface `a` characters to `o`, so that `talk` would instead be
   `tolk`.
