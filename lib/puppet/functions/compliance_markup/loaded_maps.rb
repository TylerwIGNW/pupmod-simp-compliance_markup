Puppet::Functions.create_function(:'compliance_markup::loaded_maps') do
  def initialize(closure_scope, loader)
    filename = File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) + "/puppetx/simp/compliance_mapper.rb"
    self.instance_eval(File.read(filename),filename)
    super(closure_scope, loader)
  end
  def loaded_maps()
    retval = nil
    puts "#{closure_scope.environment.name}"
    puts "loaded_maps.class = #{self.class}"
    profile_compiler = compiler_class.new(self)
    profile_compiler.load  do |k, default|
      call_function('lookup', k, { "default_value" => default})
    end
    retval = profile_compiler.compliance_data.keys
  end
  def codebase()
    "compliance_markup::loaded_maps"
  end
  def environment()
    puts "#{closure_scope.environment.name}"
    closure_scope.environment.name.to_s
  end
  def debug(message)
    false
  end
  def cache(key, value)
    nil
  end
  def cached_value(key)
    nil
  end
  def cache_has_key(key)
    false
  end
end

# vim: set expandtab ts=2 sw=2: