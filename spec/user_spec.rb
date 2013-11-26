require_relative '../lib/user'

describe User do
	let(:user) {User.new}
	context "should contain" do

	end
	context "should know" do
		it "unsolve a soduku so a user can solve it" do
			user.create_unsolved_grid
			expect(user.unsolved_grid.to_s).to include("0")
		end

	end
	context "should by default" do
	
		it "have random  solved grid" do
			expect(user.grid.solved?).to be_true
		end
	end

end
