module SessionFix 
  extend ActiveSupport::Concern
  class FakeRackSession < Hash
    # make sure session is not fully enabled
    def enabled?
      false
    end
    def destroy; end
    end
  included do
    before_action :set_fake_session
    private
    # create a fake session
    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end