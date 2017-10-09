class TestConnection
  attr_reader :identifiers, :logger

  def initialize(identifiers_hash = {})
    @identifiers = identifiers_hash.keys
    @logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(StringIO.new))
    identifiers_hash.each do |identifier, value|
      define_singleton_method(identifier) do
        value
      end
    end
  end
end

RSpec.describe NotificationsChannel do
  subject(:channel) { described_class.new(connection, {}) }

  let(:user) { FactoryGirl.create(:user) }

  subject(:channel) { NotificationsChannel.new(connection, {}) }
  let(:action_cable) { ActionCable.server }
  let(:connection) do
    TestConnection.new(current_user: user,
                       params: { user_id: user.id },
                       server: action_cable)
  end

  # ActionCable dispatches actions by the `action` attribute.
  # In this test we assume the payload was successfully parsed (it could be a JSON payload, for example).
  let(:data) do
    {
      'action' => 'send_notification',
      'user_id' => user.id
    }
  end

  it 'broadcasts a notification to the user'  do
    expect(action_cable).to receive(:broadcast).once

    channel.perform_action(data)
  end
end
