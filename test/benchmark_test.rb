require "test_helper"
require "benchmark"
require "benchmark/ips"

describe "Internal timings" do
  let(:user) { "User" }
  let(:params) { {action: "si", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }
  let(:storage) { Miau::PolicyStorage.instance }

  # run_flag = true
  run_flag ||= false

  it "times ips" do
    return unless run_flag

    Benchmark.ips do |x|
      x.report("empty       ") {}
      x.report("authorize!  ") { posts_controller.authorize! }
      x.report("authorized? ") { posts_controller.authorized? }
      # x.report("PostsPolicy.new") { PostsPolicy.new }
      # x.report("find_or_create_policy") {
      #   storage.find_or_create_policy "application"
      # }
      # x.report("name & constantize.new") {
      #   klass = :posts
      #   name = "#{klass.to_s.camelcase}Policy"
      #   name.constantize.new
      # }

      x.compare!
    end
  end
end
