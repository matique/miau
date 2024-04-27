require "test_helper"

module Aa
  class BbsControllerTest < ActionDispatch::IntegrationTest
    def test_index
      out, _err = capture_io do
        get aa_bbs_path
      end
      assert_equal "Aa::Bbs#index\n", out
    end

    def test_show
      out, _err = capture_io do
        get aa_bb_path(id: 1)
      end
      assert_equal "Aa::Bbs#show\n", out
    end
  end
end
