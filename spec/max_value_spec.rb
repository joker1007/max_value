require 'spec_helper'

describe MaxValue do
  let(:object_array) { [
    Hashie::Mash.new({id: 1, name: "name1"}),
    Hashie::Mash.new({id: 2, name: "name2"}),
    Hashie::Mash.new({id: 3, name: "name3"}),
  ] }

  describe "object_array" do
    describe "#max_value(:id)" do
      subject { object_array.max_value(:id) }

      it { should eq 3 }
    end

    describe "#max_value(:name)" do
      subject { object_array.max_value(:name) }

      it { should eq "name3" }
    end
  end
end
