require 'spec_helper'

describe MaxValue do
  describe "object_array" do
    let(:object_array) { [
      Hashie::Mash.new({id: 1, name: "name_c"}),
      Hashie::Mash.new({id: 2, name: "name_a"}),
      Hashie::Mash.new({id: 3, name: "name_z"}),
      Hashie::Mash.new({id: 4, name: "name_b"}),
    ] }

    describe "#max_value(:id)" do
      subject { object_array.max_value(:id) }

      it { should eq 4 }
    end

    describe "#max_value(:name)" do
      subject { object_array.max_value(:name) }

      it { should eq "name_z" }
    end

    describe "#max_value(:id) with block" do
      subject { object_array.max_value(:id, &:name) }

      it { should eq 3 }
    end

    describe "#min_value(:id)" do
      subject { object_array.min_value(:id) }

      it { should eq 1 }
    end

    describe "#min_value(:name)" do
      subject { object_array.min_value(:name) }

      it { should eq "name_a" }
    end

    describe "#min_value(:id, &:name)" do
      subject { object_array.min_value(:id, &:name) }

      it { should eq 2 }
    end

    describe "#sort_value(:id, &:name)" do
      subject { object_array.sort_value(:id, &:name).take(2) }

      it { should eq [2, 4] }

      describe "lazy access" do
        subject { object_array.lazy.sort_value(:id, &:name) }

        it { should be_a(Enumerator::Lazy) }
      end
    end
  end

  describe "hash_array" do
    let(:hash_array) { [
      {id: 1, name: "name_c"},
      {id: 2, name: "name_a"},
      {id: 3, name: "name_z"},
      {id: 4, name: "name_b"},
    ] }

    describe "#max_value(:id)" do
      subject { hash_array.max_value(:id) }

      it { should eq 4 }
    end

    describe "#max_value(:name)" do
      subject { hash_array.max_value(:name) }

      it { should eq "name_z" }
    end

    describe "#max_value(:id, &:name)" do
      subject { hash_array.max_value(:id) {|h| h[:name] } }

      it { should eq 3 }
    end

    describe "#min_value(:id)" do
      subject { hash_array.min_value(:id) }

      it { should eq 1 }
    end

    describe "#min_value(:name)" do
      subject { hash_array.min_value(:name) }

      it { should eq "name_a" }
    end

    describe "#min_value(:id, &:name)" do
      subject { hash_array.min_value(:id) {|h| h[:name] } }

      it { should eq 2 }
    end

    describe "#sort_value(:id, &:name)" do
      subject { hash_array.sort_value(:id) {|h| h[:name]}.take(2) }

      it { should eq [2, 4] }

      describe "lazy access" do
        subject { hash_array.lazy.sort_value(:id) {|h| h[:name]}.take(2) }

        it { should be_a(Enumerator::Lazy) }
      end
    end
  end
end
