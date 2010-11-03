Scala TextMate Bundle
=====================

Using it
--------

**Snippets** 

As any good textmate bundle this one comes with a bunch of snippets that will make you more productive. To make it easier for you to remember all of the tab-completions the bundle strives to use the keywords as tab-triggers. As an example: If you wanted to create a new class you would simply write "class" and hit tab. If you wanted to create a case class you would type "case class" and hit tab and so on. 

This of course means that the tab-triggers aren't as short as they could have been. If you're programming Scala every day you would probably prefer that you would only have to type "cc" and hit tab and it would expand into a case class. Now, Textmate doesn't allow a snippet to have multiple tab trigger (i.e. both "case class" and "cc") and having duplicated snippets would be a mess to maintain. So to fix this most of the snippets have a shorter version with expand to the "larger" version which in turn can expand to the full source. Here's and example

cc &lt;tab&gt; => case class &lt;tab&gt; => proper source for a case class

This means you have to hit tab twice but I think that's a fair tradeoff.

**Other**

First off, some of the nicest features of this bundle requires a ctags file of your project. To create one simply run the <code>Create Index File</code> command by pressing ⌃⌥⌘T.

- **Navigation (⇧⌘C)**
  This will display a list of all the traits/classes/objects/types in the project. Simply pick the one you want and press enter and TextMate will jump to the appropriate line in the file where you declare that class/trait (etc.).
- **Comments**
  - Javadoc for line (⌃⇧D): Will analyze the the current line and add the appropriate documentation for the line (i.e. correct @param etc.)
  - New javadoc line (shift-enter in comment scope): Will create a new correctly indented comment line.
- **Refactoring**
  - Organize imports (⌃⇧O): This will take the current selection and organize the imports alphabetically
  - Reformat Document (⌃⇧H): This will reformat the current document using [Scalariform](http://github.com/mdr/scalariform)

Installation
------------

To install the bundle simply run the following in your terminal:

<pre><code>git clone git://github.com/mads379/scala.tmbundle.git
open scala.tmbundle
</code></pre>

Add the shell variable <code>SCALA\_HOME</code> in TextMate -> Preferences... -> Advanced -> Shell Variables to the root of your scala installation. If you installed scala using MacPorts, it probably is <code>/opt/local/share/scala-2.8</code>

It might work best if used in conjunction with [the theme Paul Phillips use](http://github.com/paulp/scala.tmtheme) or [the theme I use](http://github.com/mads379/Github_flavor.tmtheme) alongside it:

About
-----

**If you're on a slightly older system Dan Oxlade is currently maintaining a 32bit compatible version of the bundle. Get it from his fork [here](http://github.com/oxlade39/scala.tmbundle "here")**

I wasn't happy with the official [TextMate](http://macromates.com/) bundle so I started my own bundle. It has since been hugely improved by [Paul Phillips](http://github.com/paulp) and is now vastly better than the original one. It still needs some work but it is very usable (I use it for all my Scala development)
