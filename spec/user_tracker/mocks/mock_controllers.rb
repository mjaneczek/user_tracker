class MockController < ApplicationController
  def create
    raise_after_filter("create")
  end

  def update
    @update_item = "Person"
    raise_after_filter("update")
  end
end

class OtherMockController < MockController
end