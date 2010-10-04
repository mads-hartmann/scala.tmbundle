Scala TextMate Bundle
=====================

About
-----

**If you're on a slightly older system Dan Oxlade is currently maintaining a 32bit compatible version of the bundle. Get it from his fork [here](http://github.com/oxlade39/scala.tmbundle "here")**

I wasn't happy with the official [TextMate](http://macromates.com/) bundle so I started my own bundle. It has since been hugely improved by [Paul Phillips](http://github.com/paulp) and is now vastly better than the original one. It still needs some work but it is very usable (I use it for all my Scala development)

Installation
------------

To install the bundle simply run the following in your terminal:

<pre><code>git clone git://github.com/mads379/scala.tmbundle.git
open scala.tmbundle
</code></pre>

Add the shell variable <code>SCALA\_HOME</code> in TextMate -> Preferences... -> Advanced -> Shell Variables to the root of your scala installation. For me this is <code>/Users/Mads/dev/programming_languages/scala-2.8.0.final</code>

Also, some of the features of the bundle uses ctags, so please add the following to your ~/.ctags file (If you haven't got one, simply create one)

<pre><code>--langdef=scala
--langmap=scala:.scala
--regex-scala=/^[ \t]*class[ \t]+([a-zA-Z0-9_]+)/\1/c,classes/
--regex-scala=/^[ \t]*trait[ \t]+([a-zA-Z0-9_]+)/\1/t,traits/
--regex-scala=/^[ \t]*type[ \t]+([a-zA-Z0-9_]+)/\1/T,types/
--regex-scala=/^[ \t]*def[ \t]+([a-zA-Z0-9_\?]+)/\1/m,methods/
--regex-scala=/^[ \t]*val[ \t]+([a-zA-Z0-9_]+)/\1/C,constants/
--regex-scala=/^[ \t]*var[ \t]+([a-zA-Z0-9_]+)/\1/l,local variables/
--regex-scala=/^[ \t]*package[ \t]+([a-zA-Z0-9_.]+)/\1/p,packages/
--regex-scala=/^[ \t]*case class[ \t]+([a-zA-Z0-9_]+)/\1/c,case classes/
--regex-scala=/^[ \t]*final case class[ \t]+([a-zA-Z0-9_]+)/\1/c,case classes/
--regex-scala=/^[ \t]*object[ \t]+([a-zA-Z0-9_]+)/\1/o,objects/
--regex-scala=/^[ \t]*private def[ \t]+([a-zA-Z0-9_]+)/\1/pd,defs/</code></pre>

It might work best if used in conjunction with [the theme Paul Phillips use](http://github.com/paulp/scala.tmtheme) or [the theme I use](http://github.com/mads379/Github_flavor.tmtheme) alongside it:

Using it
--------

First off, some of the nicest features of this bundle requires a ctags file of your project. To create one simply run the <code>Create Index File</code> command by pressing ⌃⌥⌘T.

- **Navigation (⇧⌘C)**
  This will display a list of all the traits/classes/objects/types in the project. Simply pick the one you want and press enter and TextMate will jump to the appropriate line in the file where you declare that class/trait (etc.).
- **Comments**
  - Javadoc for line (⌃⇧D): Will analyze the the current line and add the appropriate documentation for the line (i.e. correct @param etc.)
  - New javadoc line (shift-enter in comment scope): Will create a new correctly indented comment line.
- **Refactoring**
  - Organize imports (⌃⇧O): This will take the current selection and organize the imports alphabetically
  - Reformat Document (⌃⇧H): This will reformat the current document using [Scalariform](http://github.com/mdr/scalariform)
