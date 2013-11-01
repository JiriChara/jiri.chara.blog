module Karmable
  def self.included(base)
    base.has_many :karmas, as: :karmable

    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def karma
      karmas.collect(&:value).inject(&:+) || 0
    end

    def positive_karma
      karmas.collect(&:value).select { |val| val == 1 }.inject(&:+) || 0
    end

    def negative_karma
      k = karmas.collect(&:value).select { |val| val == -1 }.inject(&:+) || 0
      k.abs
    end
  end
end
