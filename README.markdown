Scala TextMate Bundle
=====================

Textmate bundle for the Scala Programming Language. 

Using it
--------

**Snippets** 

As any good textmate bundle this one comes with a bunch of snippets that will make you more productive. To make it easier for you to remember all of the tab-completions the bundle strives to use the keywords as tab-triggers. As an example: If you wanted to create a new class you would simply write "class" and hit tab. If you wanted to create a case class you would type "case class" and hit tab and so on. 

This of course means that the tab-triggers aren't as short as they could have been. If you're programming Scala every day you would probably prefer that you would only have to type "cc" and hit tab and it would expand into a case class. Now, Textmate doesn't allow a snippet to have multiple tab trigger (i.e. both "case class" and "cc") and having duplicated snippets would be a mess to maintain. So to fix this most of the snippets have a shorter version with expand to the "larger" version which in turn can expand to the full source. Here's and example

cc &lt;tab&gt; => case class &lt;tab&gt; => proper source for a case class

This means you have to hit tab twice but I think that's a fair tradeoff.

**Playing with the code**

The bundle offers several ways to play around with Scala code in your document - Hit ⌘R and see the options possible

- **Scala REPL**: This will start the Scala REPL in a new tab in the a frontmost terminal window or create a new window if one doesn't exist. 
- **Scala REPL: Preload file** This will start the Scala REPL like above but it will preload the current file
- **Scala REPL: Paste selection** This will paste the current selection in TextMate to active Terminal tab.

**Other cool stuff**
- **Align Assignments**: This will align anything according to =>,=,->,<-. 
- **Comments**
  - Javadoc for line (⌘⇧D): Will analyze the the current line and add the appropriate documentation for the line (i.e. correct @param etc.)
  - New javadoc line (⇧⏎ in comment scope): Will create a new correctly indented comment line.

Shell variables
---------------

- **SCALA_DOC**: If you want to browse the documentation offline, set this shell variable. Here's how mine is set: /Users/Mads/dev/programming\_languages/scala-2.8.1.final-devel-docs
- **SCALA_HOME**:If you want to be able to run and/or compile single files from within textmate /Users/Mads/dev/programming\_languages/scala-2.8.0.final/
- **SCALA_COMPILER**:Defaults to scalac. 

Installation
------------

<pre><code>git clone git://github.com/mads379/scala.tmbundle.git
open scala.tmbundle
</code></pre>

Contributors
------------

- Mads Hartmann Jensen
- Paul Phillips (paulp)
- (murr4y)
- (mikemckibben)
- (fizx)
