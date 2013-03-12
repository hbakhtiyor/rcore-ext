require 'spec_helper'
require 'rcore_ext/string/format'

describe "String formats" do
  let(:plain_text)  { "plain text" }
  let(:url_safe)    { "https://github.com/hbakhtiyor/rcore-ext" }

  describe "respond to encode/decode methods" do
    it "should respond to encode method" do
      "".should respond_to :encode_string
    end

    it "should respond to decode method" do
      "".should respond_to :decode_string
    end
  end

  describe "raise exceptions" do
    describe "in encode method" do
      it "should raise exception with empty format" do
        expect { "".encode_string }.to raise_error ArgumentError
      end

      it "should raise exception with unsupported format" do
        expect { "".encode_string(:unsupported_format) }.to raise_error ArgumentError
      end
    end

    describe "in decode method" do
      it "should raise exception with empty format" do
        expect { "".decode_string }.to raise_error ArgumentError
      end

      it "should raise exception with unsupported format" do
        expect { "".decode_string(:unsupported_format) }.to raise_error ArgumentError
      end
    end   
  end

  describe "bin format" do
    let(:bin_string) { "01110000011011000110000101101001011011100010000001110100011001010111100001110100" }

    describe "decoding functionality" do
      it "should only contain [01] characters" do
        plain_text.decode_string(:bin).should =~ /^[01]+$/
      end

      it "should decode correctly" do
        plain_text.decode_string(:bin).should == bin_string
      end
    end

    describe "encoding functionality" do
      it "should encode correctly" do
        bin_string.encode_string(:bin).should == plain_text
      end
    end     
  end

  describe "hex format" do
    let(:hex_string) { "706c61696e2074657874" }

    describe "decoding functionality" do
      it "should only contain [0-9a-f] characters" do
        plain_text.decode_string(:hex).should =~ /^[0-9a-f]+$/i
      end

      it "should decode correctly" do
        plain_text.decode_string(:hex).should == hex_string
      end     
    end

    describe "encoding functionality" do
      it "should encode correctly" do
        hex_string.encode_string(:hex).should == plain_text
      end     
    end
  end

  describe "base32 format" do
    let(:base32_string) { "OBWGC2LOEB2GK6DU" }

    describe "decoding functionality" do
      it "should decode correctly" do
        base32_string.decode_string(:base32).should == plain_text
      end       
    end

    describe "encoding functionality" do
      it "should only contain [2-7a-z=] characters" do
        plain_text.encode_string(:base32).should =~ /^[2-7a-z=]+$/i
      end

      it "should encode correctly" do
        plain_text.encode_string(:base32).should == base32_string
      end       
    end   
  end

  describe "base64 format" do
    let(:base64_string)         { "cGxhaW4gdGV4dA==\n" }
    let(:base64_strict_string)  { "cGxhaW4gdGV4dA==" }
    let(:base64_urlsafe_string) { "aHR0cHM6Ly9naXRodWIuY29tL2hiYWtodGl5b3IvcmNvcmUtZXh0" }

    describe "decoding functionality" do
      it "should decode correctly" do
        base64_string.decode_string(:base64).should == plain_text
      end

      it "should decode with strict option" do
        base64_strict_string.decode_string(:base64, strict: true).should == plain_text
      end

      it "should decode with url_safe option" do
        base64_urlsafe_string.decode_string(:base64, url_safe: true).should == url_safe
      end         
    end

    describe "encoding functionality" do
      it "should only contain [0-9a-z=+/] characters" do
        plain_text.encode_string(:base64).should =~ /^[0-9a-z=\/\+]+$/i
      end

      it "should encode correctly" do
        plain_text.encode_string(:base64).should == base64_string
      end

      it "should decode with strict option" do
        plain_text.encode_string(:base64, strict: true).should == base64_strict_string
      end

      it "should decode with url_safe option" do
        url_safe.encode_string(:base64, url_safe: true).should == base64_urlsafe_string
      end                       
    end   
  end
end