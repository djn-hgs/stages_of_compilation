# I'll forget this stuff so...



## Stages of compilation

### Lexical analysis

This is the stage where the compiler _parses_ the source code and extracts the relevant terms into _tokens_ that the compiler understands. For instance, you might write the text `float a = b * c` and the tokens will be `float`, `a`, `=`, `b` and `c`.

You can see this happening if you run `gcc -E -fdebug-cpp mult.c`, which will show the tokenized code along with a lot of scary metadata.

There is no meaning associated with the tokens at this stage but they are now in a form that the compiler understands and can use.

Many languages will also have the ability to pass information for pre-processing. So, in `C` for instance, `#include "mult.c"` will replace the line with the contents of the file `mult.c` before tokenisation occurs. Any line beginning with a `#` will only be dealt with by the pre-processor and will be ignored during lexical analysis.

### Syntax analysis

Now the code has been converted into terms that the compiler can understand it will then ensure that they have been combined and structured so that they make sense.

So the token `float` would only make sense before another term representing a variable (or maybe a function). The compiler will know all the possible situations and check to see that one is matched.

The token `*` would (perhaps) only make sense between two terms which are variables, numbers or functions. It will check against possibilities. 

Note that something like `a * 3` would not _make sense_ if `a` hadn't been declared to be a number or something that can be multiplied by 3. This is _not_ an error in syntax, however, and so may well not cause problems at this stage - it depends on how the compiler operates: that's what _semantic analysis_ is about. 

The syntactic analysis process enables the compiler to structure the tokens into a _syntax tree_ (or Abstract Syntax Tree... AST). To my knowledge GCC does not make it possible to see its AST but we'll see...

### (Semantic analysis)

The OCR syllabus makes no reference to _semantic analysis_ and - to be honest - it is hard to tell to what extent this is a different stage in the operation of a compiler, but most discussions do single it out so here we go.

Once our code has been tokenised and organised as a syntax tree, the compiler will then make sure that it makes sense. _Semantic_ is a posh word for "meaning" and "interpretation", and this is what the compiler is checking for in our code...

So, for example, if you have previously written the line `float b = 2, c = 3` and then the line `float a = b * c` then that will usually compile just fine. But if we previously had written `char b[] = "2", char c[] = "3"` then this will throw an error before compilation occurs, because it doesn't make sense! This process is called _type checking_.

Semantic analysis _will_ happen and it only makes sense once the structure of the code has been analysed. So this semantic analysis is considered as distinct in the design of the process, even though the reality may be that it happens _alongside_ syntax analysis. [This is discussed at great length here](https://stackoverflow.com/questions/62678079/what-differentiates-syntax-analysis-and-semantic-analysis#:~:text=In%20the%20practice%20of%20compiler%20development%2C%20however%2C%20the,code%2C%20attached%20to%20the%20rules%20in%20the%20grammar).

### Code creation

Now the compilation actually happens. The compiler will traverse the AST (or something equivalent to an AST) and map the content to program code.

Some compilers will produce machine code directly whereas others might use intermediate assembly code. You can see this in gcc using `gcc -S mult.c`.

At this stage any library functions, or those contained in other files will only be referred to via their headers. So this _object code_ is not yet executable; it will need linking in order to provide a complete program. 

### Linking

A linker will take the various pieces of object code, both from the user program and from library routines and combine (_link_) them so as to produce a self-contained executable program, eg `gcc mult.o mult.o`. This is where the terminology of _object code_ comes from: the linker takes the _object code_ and combines it to create _target code_.

Even if we have not written subroutines in separate files, and reference to `<stdio.h>` or similar is going to be dealt with by the linker.

### (Code optimisation)

Most detailed treatments will talk about the role of code optimisation in this process. In reality it will be involved at all stages, in the source code, the object code and the final code. There will be redundant code that can be simply thrown away as well as standard code patterns that can be dealt with in a more efficient manner.

### Loading (not a stage of compilation)

Once a program has been compiled to executable code, we need to be able to run it! The operating system will provide a means to load and run a binary file (eg `./aout` or clicking an icon on the desktop) and will manage redirection of memory references in the executable so as to enable many (usually hundreds) of applications to be memory-resident simultaneously and sharing use of the CPU's cores and registers.

Of course, the computer's startup "bootstrap" process must involve loaders: when the computer starts up, the contents of the BIOS's flash memory are loaded to the main memory and executed; this will then enable the BIOS to search attached secondary storage (or even LAN) for bootloader code, which it in turn will then load to memory and execute in order to enable the operating system to start up.

## GCC

GCC stands for the GNU Compiler Collection.

It was a key part of Stallman's GNU project and was what enabled Linus Torvalds to start building a POSIX compliant kernel - the beginning of the Linux project.

We use it to compile our code. But we can get extra information...

## GCC switches

`gcc main.c` will compile the file `main.c`, by default to the file `a.out`.

`gcc mult.c main.c` will compile both files together, allowing for subroutines to be shared.

`gcc -c mult.c` will compile object code (`mult.o`) ready to be linked.

Lines of the form `#include` are directives to the preprocessor: you'll see some in `main.c` and `mult.c`. 

If `main.c` contains a reference to the header `mult.h` then `gcc -c main.c` will prepare object code for `main.c` ready to be linked with corresponding object code from `mult.c`.

`gcc mult.o mult.o` will link the object code from the two files, producing an excecutable.

`gcc -S mult.c` will produce the assembly language that will be assembled into object code.

`gcc -E -fdebug-cpp mult.c` will show the tokenized code.