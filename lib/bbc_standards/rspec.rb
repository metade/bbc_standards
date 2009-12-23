module Spec
  module Matchers
    def obey_bbc_standards
      Matcher.new :obey_bbc_standards do
        validator = nil
        match do |xhtml|
          validator = BBCStandards::Validator.new xhtml
          validator.valid?
        end

        failure_message_for_should do |actual|
          validator.inspect
        end
      end
    end
  end
end
