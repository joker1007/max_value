require "max_value/version"

module MaxValue
end

module Enumerable
  def max_value(sym, &block)
    __by_value__(:max_by, sym, &block)
  end

  def min_value(sym, &block)
    __by_value__(:min_by, sym, &block)
  end

  def sort_value(sym, &block)
    sorter = block ? block : sym
    sorted = sort_by(&sorter)
    if is_a?(Enumerator::Lazy)
      sorted.lazy.map{ |o| __fetch_value__(o, sym) }
    else
      sorted.map{ |o| __fetch_value__(o, sym) }
    end
  end

  private

  def __by_value__(method_name, sym, &block)
    sorter = block ? block : __symbol_to_sorter__(sym)
    __fetch_value__(send(method_name, &sorter), sym)
  end

  def __fetch_value__(object, sym)
    (object.respond_to?(sym) ? object.send(sym) : (object[sym] || object[sym.to_s]))
  end

  def __symbol_to_sorter__(sym)
    ->(x) { __fetch_value__(x, sym) }
  end
end

