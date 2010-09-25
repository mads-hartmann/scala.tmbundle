require ENV['TM_SUPPORT_PATH'] + '/lib/textmate.rb'

module Scala
	module Scalariform
		class << self
    
      NORMAL_CLASS = "normal"
      ADD_CLASS = "add"
      ADD_COLOR = "DDFFDD"
      REMOVE_CLASS = "remove"
      REMOVE_COLOR = "FFDDDD"

      def reformatDocument
        TextMate.require_env_var("SCALA_HOME", "Please set the SCALA_HOME shell variable " +
          "to the root of your scala installation. For me this is " +
          "/Users/Mads/dev/programming_languages/scala-2.8.0.final")
    
        jar   = ENV['TM_BUNDLE_SUPPORT'].gsub(' ','\ ') + "/bin/scalariform_2.8.0-0.0.5.jar"
        file  = ENV['TM_FILEPATH'].gsub(' ','\ ')
        scala = ENV['SCALA_HOME'] + "/bin/scala"
        root = "file://"+ENV['TM_BUNDLE_SUPPORT']
        
        puts "<script src='#{root}/js/jquery-1.4.2.min.js' type='text/javascript' charset='utf-8'></script>"
        puts "<script src='#{root}/js/scalarifrom.js' type='text/javascript' charset='utf-8'></script>"
        puts "<script type='text/javascript' charset='utf-8'>" +
             "var CURRENT_PATH = '#{ENV['TM_FILEPATH'].gsub(' ','\ ')}' \n" +
             "var BUNDLE_PATH = '#{ENV['TM_BUNDLE_SUPPORT'].gsub(' ','\ ').gsub(' ','\ ')}'" +
             "</script>"
        puts "<link rel='stylesheet' href='#{root}/css/diff-styles.css' type='text/css' media='screen' title='no title' charset='utf-8'>"
        puts "<style>" +
          ".#{ADD_CLASS} { background: ##{ADD_COLOR} ;}" +
          ".#{REMOVE_CLASS} { background: ##{REMOVE_COLOR} ;}" +
          "</style>"

        puts `#{scala} -cp #{jar} scalariform.commandline.Main #{file} > ~/.difffile.scala`

        diff = `diff -u #{ENV['TM_FILEPATH']} ~/.difffile.scala`

        lines = diff.split("\n")
        if lines.to_a.size > 0
          puts "<div class='header'>"
          puts "<h1>Formatted using <a href='http://github.com/mdr/scalariform' target='_blank'>Scalarifrom</a></h1>"
          puts "<p><a href='#' id='accept'>Looks great, use this</a> (hit Return)</p>"
          puts "<p><a href='#' id='cancel'>Looks horrible, I'll do my formatting myself thank you</a> (hit Escape)</p>"
          puts "</div>"
          puts "<div class='content'>"
          content = lines.
            slice(3,lines.to_a.size).
            collect{ |line| categorize(line) }.
            collect{ |line| colorize(line) }

          printWithLineNumbers(content)
        else
          puts "<div class='header'>"
          puts "<h1>Congratulations, <br /> your file doesn't need reformatting</h1>"
        end
        puts "</div>"        
      end
  
      private 
  
      def printSingleLine(line, remove_number, add_number, type)
        puts "<tr>"
        case type 
          when ADD_CLASS 
            puts "<td class='number'></td>"
            puts "<td class='number'>#{add_number}</td>"
          when REMOVE_CLASS
            puts "<td class='number'>#{remove_number}</td>"
            puts "<td class='number'></td>"
          else 
            puts "<td class='number'>#{remove_number}</td>"
            puts "<td class='number'>#{add_number}</td>"
        end
        puts "<td class='line'>#{line}</td>"
        puts "</tr>"
      end

      # Expects a list of hashes with :type and :line
      def printWithLineNumbers(lines)

        add_line = 0
        remove_line = 0

        puts "<table>"
        lines.size.times { |number|
          entity = lines[number]
          case entity[:type]
            when REMOVE_CLASS
              remove_line += 1
              printSingleLine(entity[:line], remove_line, add_line, REMOVE_CLASS)
            when ADD_CLASS
              add_line += 1
              printSingleLine(entity[:line], remove_line, add_line, ADD_CLASS)
            else
              add_line += 1
              remove_line += 1
              printSingleLine(entity[:line], remove_line, add_line, NORMAL_CLASS)
          end 
        }
        puts "</table>"
      end

      # Takes a line (string) and turns it into a hash of :type and :line
      def categorize(line) 
        state = line.chars.first
        case state 
          when "+"
            { :type => ADD_CLASS, :line => line}
          when "-"
            { :type => REMOVE_CLASS, :line => line}
          else 
            { :type => NORMAL_CLASS, :line => line}
        end
      end

      # Takes hashe with :type and :linea and colorizes the :line 
      def colorize(entity)
        { :type => entity[:type],
          :line => "<span class='#{entity[:type]}'><code>#{entity[:line]}</code></span>"
        }
      end
    end
  end
end