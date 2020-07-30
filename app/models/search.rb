class Search 
    
     @@log = []

     def self.log
          @@log
     end

     def self.reset_log
          @@log = []
     end

     def self.add_log(keyword)
          @@log << keyword
     end
end