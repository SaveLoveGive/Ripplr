%w[
   person
   lift
   log_entry
   unqueryable
  ].each do |file|
  require File.join("support", "models", file)  
end

