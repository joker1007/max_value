require "max_value/version"

module MaxValue
end

module Enumerable
  def max_value(sym)
    max_by(&sym).send(sym)
  end
end
