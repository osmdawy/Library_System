module Concerns::Rules
  extend ActiveSupport::Concern
  
  included do
    cattr_accessor :rules_hash
    cattr_accessor :rules_array
  end
  
  module ClassMethods
    def set_rules(*args)
      self.rules_array = *args
      self.rules_hash = {}
      generate_setters
      generate_getters
      generate_scope
    end
    def get_rules()
      return rules_array
    end
    private
      def generate_setters
        self.rules_array.each_with_index do |rule, rule_index|
          self.rules_hash[rule.to_s] = rule_index
          define_method rule.to_s + "!"  do
            self.rules_mask = self.rules_mask | (1 << rule_index)
            self.save!
          end  
        end
      end
      def generate_getters
        self.rules_array.each_with_index do |rule, rule_index|
          define_method rule.to_s + "?" do
            return self.rules_mask[rule_index] == 1
          end
        end
      end
      def generate_scope
        rules_array.each_with_index do |rule, rule_index|
          scope "#{rule.to_s.pluralize}", -> { self.for_js("(this.rules_mask & (1 << rule)) > 0", rule: rule_index) }
        end
      end
  end
  
  def rules=(values)
    new_rules_mask = 0
    values.each do |rule|
      if rule != ""
        rule_index = self.rules_hash[rule.to_s]
        new_rules_mask = new_rules_mask | (1 << rule_index)
      end
    end
    self.rules_mask = new_rules_mask
  end
  
  def rules
    rules_values = []

    self.rules_hash.each do |rule, rule_index|
      if self.rules_mask[rule_index] == 1
        rules_values << rule
      end
    end
    return rules_values
  end
end