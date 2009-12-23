require 'spec_helper'
require 'pp'

describe BBCStandards::Validator do
  describe "validating invalid content" do
    before(:each) do
      @validator = BBCStandards::Validator.new(%[
        <html xmlns="http://www.w3.org/1999/xhtml">
          <head>
          </head>
          <body>
            <p>
              <p>
                Hello
              </p>
            </p>
          </body>
        </html>
      ])
    end
    
    it "should add some errors" do
      @validator.errors.should_not be_empty
    end
    
    it "should return a message when inspected" do
      @validator.inspect.should_not be_empty
    end
  end
  
  describe "validating valid content" do
    before(:each) do
      @validator = BBCStandards::Validator.new(%[
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-GB" lang="en-GB">
          <head>
            <title>hello world</title>
          </head>
          <body>
            <h1>My h1</h1>
            <h2>My h2</h2>
          </body>
        </html>
      ])
    end
    
    it "should not have any errors" do
      @validator.errors.should be_empty
    end
    
    it "should return nothing when inspected" do
      @validator.inspect.should be_empty
    end
  end
end
