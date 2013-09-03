class MockController < ApplicationController
  def create
    raise_after_filter("create")
  end

  def update
    raise_after_filter("update")
  end
end