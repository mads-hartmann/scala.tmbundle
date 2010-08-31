#!/usr/bin/env ruby -wKU

support_path = ARGV[0]
type_name = ARGV[1]

require support_path + '/lib/ScalaHelper.rb'

Scala::Helper.display_inspect_type(type_name)