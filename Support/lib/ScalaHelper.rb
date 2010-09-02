###
# Some of method names contain the word type - in this case
# type means classes/traits/types/objects etc. 
#
# @Author Mads Hartmann Jensen (mads379@gmail.com)
###

module Scala
	module Helper
		class << self
		  		  
		  #
		  # constants
		  TAG_FILE_PATH = ENV['TM_PROJECT_DIRECTORY'] + "/tags"
		  PROJECT_DIR = ENV['TM_PROJECT_DIRECTORY']
		  NO_FILE_MSG = "Please create a ctags file using the Create Index File command"
		  
		  #
		  # Creates a CTAGS index file of the current project
      def create_ctags_index 
        ctags_path = ENV['TM_BUNDLE_SUPPORT'] + "/ctags"
              safe_path = ctags_path.gsub(" ",'\ ')
      
              `cd #{PROJECT_DIR} && #{safe_path} -h ".scala" -n -R --exclude=*.js --exclude=target --exclude=resources -f #{TAG_FILE_PATH} .`
      
              puts "created index file"
      end
		  
		  #
		  # Displays a list (in HTML) of all of the types/traits/classes/objects
		  # in the project
		  def display_types
		    
        hash = list_sources()
        if !hash.nil?
          selection = begin 
        	  s = ENV['TM_SELECTED_TEXT']
        	  if !s.nil? then s else "" end
          end

          makeHTMLHeader()
          makeHTMLTop()
          puts "<div id='content'>"
          makeHTMLListOfTypes(hash,selection)
          puts "</div>"
          makeHTMLFooter()

        end
	    end
		  
		  #
		  # Return HTML with a list of all of the members of that type.
		  def display_inspect_type(name)
        hash = inspect_type(name)
        if !hash.nil?
          makeHTMLListOfTypes(hash,"")
        end
		  end
		  
		  def package_of_path(file) 
		    project = ENV['TM_PROJECT_DIRECTORY']
        name = ENV['TM_FILENAME']
        packageName = file.gsub(project+"/","").gsub("/"+name,"").gsub("src/","").gsub("main/scala/","").gsub("/",".")
        return packageName
	    end
		  	  
		  private
		  
		  #--- Helpers
		  #
		  
		  #
		  # Returns a hash with an item for each method/val definition in the
		  # scope of the type. The hash contains the name, file, type, linenumber.
		  def inspect_type(name)
		    if File.exists?(TAG_FILE_PATH)

		        output = `grep "#{name}$" #{TAG_FILE_PATH}`
		        lines = output.split("\n")
		        lines.collect{ |line|
  		        parts = line.split("\t")
              { 'name' => parts[0],
                'path' => parts[1],
                'line' => parts[3],
                'type' => parts[2]}
  		      }
		    else
		      puts NO_FILE_MSG
	      end
		  end
		  
		  #
		  # Returns a hash with an item for each class/trait/object definition in the
		  # project. The hash contains the name, file, linenumber.
		  def list_sources 
		    if File.exists?(TAG_FILE_PATH)
		      output = `grep "[o|c|t|T]$" #{TAG_FILE_PATH}`
		      lines = output.split("\n")
		      lines.collect{ |line|
		        parts = line.split("\t")
            { 'name' => parts[0],
              'path' => PROJECT_DIR + "/" + parts[1],
              'line' => parts[2].gsub(';"',""),
              'type' => parts[3]}
		      }.select{ |line| 
    		    # If an object isn't capitalized it's probably just used as a
  		      # variable. So we don't want that poluting thel ist.
    		    line['name'].chars.to_a.first == line['name'].chars.to_a.first.capitalize
          }		      
		    else
		      puts "Please create a ctags file using the Create Index File command"
		      nil
		    end
		  end
		  
		  #
		  # Returns a hash with an item for each class/trait/object definition in the
		  # project. The hash contains the name, file, type , linenumber.
		  # def list_sources 
		  #         if File.exists?(TAG_FILE_PATH)
		  #           output = `grep "[[:space:]][O|c][[:space:]]" #{TAG_FILE_PATH}`
		  #           lines = output.split("\n")
		  #           lines.collect{ |line|
		  #             parts = line.split("\t")
		  #             { 'name' => parts[0],
		  #               'path' => parts[1],
		  #               'line' => parts[3],
		  #               'type' => parts[2]}
		  #           }.select{ |line| 
		  #             # If an object isn't capitalized it's probably just used as a
		  #             # variable. So we don't want that poluting thel ist.
		  #             line['name'].chars.to_a.first == line['name'].chars.to_a.first.capitalize
		  #           }         
		  #         else
		  #           puts NO_FILE_MSG
		  #           nil
		  #         end
		  #       end
		  
		  # Gets the entire ctags line that describes the type with the given name
		  # @param  name  the name of the type to search for
		  def ctags_line_for_type(name)
		    if File.exists?(TAG_FILE_PATH)
		      output = `grep "^#{name}" #{TAG_FILE_PATH}`
		      return output
	      else
	        puts NO_FILE_MSG
        end
		  end
		  
		  # returns the line where the definition of the type is
		  # @param  name  the name of the type to search for
		  def lineOfType(name)
		    if File.exists?(TAG_FILE_PATH)
		      parts = ctags_line_for_type(name).split("\t")
		      return parts[3]
	      else
	        puts NO_FILE_MSG
        end
      end
      
      # return the path to the file that defines the type with the given name
      # @param  name  The name of the type to search for
		  def pathOfType(name)
		    if File.exists?(TAG_FILE_PATH)
		      parts = ctags_line_for_type(name).split("\t")
		      return + parts[1]
	      else
	        puts NO_FILE_MSG
        end
	    end
		  		  
		  #--- HTML helpers
		  #
		  def makeHTMLHeader
        root = "file://"+ENV['TM_BUNDLE_SUPPORT']
        puts "<link rel='stylesheet' href='#{root}/css/navigator.css' type='text/css' media='screen' title='no title' charset='utf-8'>"
        puts "<script src='#{root}/js/jquery-1.4.2.min.js' type='text/javascript' charset='utf-8'></script>"	
        puts "<script src='#{root}/js/navigator.js' type='text/javascript' charset='utf-8'></script>"	
        puts "<script type='text/javascript' charset='utf-8'>"
        puts "var root = '#{root}'"
        puts "</script>"	
      end

      def makeHTMLTop
        puts "<div class='top'><input type='search' /></div>"
      end

      def makeHTMLFooter 
        puts "<div id='footer'></div>"
      end

      def makeHTMLListOfTypes(items,selection)
        puts "<ul>"
        items.each do |item|
          if (item['name'] == selection) 
            puts "<li class='selected'>" 
          else
            puts "<li>"
          end
          puts "<span class='package'>" + package_of_path(item['path']) + "</span>"
      	  puts "<p class='" + item['type'] + "'>" + item['name'] 
      	  puts "</p>"	 
       	  puts "<span class='path'>" + item['path'] + "</span>"
       	  puts "<span class='line'>" + item['line'] + "</span>"
          puts "</li>"
        end
        puts "</ul>"
      end
		  
		end
	end
end