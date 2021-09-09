require "test_helper"
require "benchmark"
require "benchmark/ips"

describe "Internal timings" do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

  # run_flag = true
  run_flag ||= false

  def setup
  end

  it "times ips" do
    return unless run_flag

    Benchmark.ips do |x|
      x.report("empty       ") {}
      x.report("authorize!  ") { posts_controller.authorize! }
      x.report("authorized? ") { posts_controller.authorized? }

      x.compare!
    end
  end
end
