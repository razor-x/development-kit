require 'spec_helper'

describe Kit::Bit::Utility do

  describe ".make_random_directory" do

    root, prefix = '/tmp', 'rspec'

    it "makes a directory where expected" do
      dir = Kit::Bit::Utility.make_random_directory root, prefix
      expect(Dir.exists? dir).to be_true
      FileUtils.remove_entry_secure dir if dir =~ %r{^/tmp}
    end
  end

  describe ".validate_path" do

    context "valid path" do

      it "returns the input path" do
        expect(Kit::Bit::Utility.validate_path '/path').to eq '/path'
      end

      it "returns the input path when the root path matches" do
        expect(Kit::Bit::Utility.validate_path '/path/to/dir', '/path/to').to eq '/path/to/dir'
      end

    end

    context "bad path" do

      it "rasises an error if path contains '../'" do
        expect { Kit::Bit::Utility.validate_path 'path/with/../in/it' }.to raise_error RuntimeError
      end

      it "rasises an error if using '~/'" do
        expect { Kit::Bit::Utility.validate_path '~/path' }.to raise_error RuntimeError
      end

      it "rasises an error if given root does not match path root" do
        expect { Kit::Bit::Utility.validate_path '/other_root/path', '/root/path' }.to raise_error RuntimeError
      end
    end
  end
end
