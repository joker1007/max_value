require "max_value/version"

module MaxValue
end

module Enumerable
  def max_value(sym, &block)
    sorter = block ? block : sym
    max_by(&sorter).send(sym)
  end

  def min_value(sym, &block)
    sorter = block ? block : sym
    min_by(&sorter).send(sym)
  end

  def sort_value(sym, &block)
    sorter = block ? block : sym
    sorted = sort_by(&sorter)
    if is_a?(Enumerator::Lazy)
      sorted.lazy.map(&sym)
    else
      sorted.map(&sym)
    end
  end
end
