
RSpec.describe Link do
  # validation tests
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:url) }
    #it { is_expected.to validate_uniqueness_of(:url) }
  end

  # class method tests
  describe ".hottest_first" do
    it "returns the links: hottest to coldest" do
      coldest_link = create(:link, upvotes: 3, downvotes: 3)
      hottest_link = create(:link, upvotes: 5, downvotes: 1)
      lukewarm_link = create(:link, upvotes: 2, downvotes: 1)

      expect(Link.hottest_first).to eq [hottest_link, lukewarm_link, coldest_link]
    end
  end

  # instance method tests
  describe "#upvote" do
    it "increments upvotes" do
      link = build(:link, upvotes: 1)

      link.upvote

      expect(link.upvotes).to eq 2
    end
  end

  describe "#downvote" do
    it "increments downvotes" do
      link = build(:link, downvotes: 1)

      link.downvote

      expect(link.downvotes).to eq 2
    end
  end

  describe "#score" do
    it "returns Score object for this link" do
      link = Link.new(upvotes: 2, downvotes: 1)

      expect(link.score).to eq Score.new(link)
    end
  end

  describe "#image?" do
    %w(.jpg .gif .png).each do |extension|
      it "returns true if the URL ends in #{extension}" do
        link = Link.new(url: "http://example.com/a#{extension}")

        expect(link.image?).to be_truthy
      end
    end

    it "returns false if the URL does not have an image extension" do
      link = Link.new(url: "http://not-an-image")

      expect(link.image?).to be_falsey
    end
  end
end
