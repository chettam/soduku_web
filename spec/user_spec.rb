require_relative '../lib/user'

describe User do
	let(:user) {User.new}
	context "should contain" do
	
		it "a random  solved grid" do
			expect(user.grid.solved?).to be_true
		end
	end
	context "should know" do
	
		it "a random  solved grid" do
			expect(user.grid.solved?).to be_true
		end
	
	end
	context "should by default" do
	
		it "have random  solved grid" do
			expect(user.grid.solved?).to be_true
		end
	
	end

end
