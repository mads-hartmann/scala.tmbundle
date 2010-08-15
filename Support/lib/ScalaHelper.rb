module Scala
	module Helper
		class << self
		  
		  #
		  # constants
		  TAG_FILE_PATH = ENV['TM_PROJECT_DIRECTORY'] + "/tags"
		  PROJECT_DIR = ENV['TM_PROJECT_DIRECTORY']
		  
		  #
		  # Creates a CTAGS index file of the current project
		  def create_ctags_index 
		    ctags_path = ENV['TM_BUNDLE_SUPPORT'] + "/ctags"
        safe_path = ctags_path.gsub(" ",'\ ')

        `cd #{PROJECT_DIR} && #{safe_path} -h ".scala" -n -R --exclude=*.js -f #{TAG_FILE_PATH} .`

        puts "created index file"
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
              'line' => parts[2].gsub(';"',"")}
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
		  
		end
	end
end