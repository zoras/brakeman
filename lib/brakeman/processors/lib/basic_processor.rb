require 'brakeman/processors/lib/processor_helper'
require 'brakeman/util'

class Brakeman::BasicProcessor < Brakeman::SexpProcessor
  include Brakeman::ProcessorHelper
  include Brakeman::Util

  def initialize tracker
    super()
    @tracker = tracker
    @current_template = @current_module = @current_class = @current_method = nil
  end

=begin
  def process exp
    x = exp.deep_clone
    super exp
    abort "ERMAGAD #{self.class}" unless x == exp or Brakeman::BaseProcessor === self
    exp
  end
=end
end
