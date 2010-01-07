module BBCStandards
  class Validator
    include Spec::Matchers
    
    attr_reader :errors
    
    def initialize(xml)
      @xml = xml
      # TODO: remove this once Barlesque sorts out the BBC Search form
      @xml.sub!('<form method="get" action="http://search.bbc.co.uk/search" accept-charset="utf-8"><fieldset><input',
        '<form method="get" action="http://search.bbc.co.uk/search" accept-charset="utf-8"><fieldset><legend>foo</legend><input')
      @doc = Nokogiri::HTML(xml)
      @errors = []
      validate
    end
    
    def valid?
      @errors.empty?
    end
    
    def inspect
      lines = @xml.split("\n")
      strings = []
      errors.each do |error|
        if error.line
          start = error.line - [2, error.line].min
          error_line = error.line == 0 ? 1 : error.line
          strings << "Error on line: #{error_line}:"
          strings << error.message.gsub(/\{[^\}]*\}/, '')
          Range.new(start, error.line + 2).each { |number|
            strings << "#{number + 1}: #{lines[number]}"
          }
          strings << ""
        else
          strings << error.message
        end
      end
      strings.join("\n")
    end
    
    protected
    
    def validate
      test_validation
      test_accessibility
      test_bbc_standards
    end

    def test_validation
      validator = MarkupValidity::Validator.new(@xml, MarkupValidity::Validator::XHTML1_STRICT)
      @errors += validator.errors
    end
    
    def test_accessibility
      rt = Raakt::Test.new(@xml)
      @errors += rt.all.map { |e| Error.new(e.text) }
    end
    
    def test_bbc_standards
      @errors << Error.new("Title is not valid") unless @xml =~ /<title>\w+( - )?([^<-]+)?( - )?([^<-]+)?<\/title>/
      @errors << Error.new("Page doesn't have 1 <h1> tag") unless @doc.xpath('//h1').size == 1
      @errors << Error.new("Page doesn't have any <h2> tags") unless @doc.xpath('//h2').size > 0
      @errors << Error.new("Page is using <br> for whitespace") if @xml =~ /<br\/>\s*<br\/>/
      %w(b i font marquee).each do |tag|
        @errors << Error.new("Page is using <#{tag}>") if @doc.xpath("//#{tag}").any?
      end
    end
  end
  
  class Error
    attr_accessor :message, :line
    
    def initialize(message, line=nil)
      @message = message
      @line = line
    end
  end
end
