# Prompt with ruby version
# Borrowed from http://lucapette.com/pry/pry-everywhere/
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (#{obj}):#{nest_level} > " },
              proc { |obj, nest_level| "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (#{obj}):#{nest_level} * " }]

# Set default editor
Pry.config.editor = "vim"
