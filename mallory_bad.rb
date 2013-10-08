require "sinatra"
require "loggregator_emitter"

begin
emitter = LoggregatorEmitter::Emitter.new(
    "1.1.1.1:3456",
    LogMessage::SourceType::CLOUD_CONTROLLER,
    0
)
rescue
  puts "Yeah... whatever."
end
emitter.instance_variable_set("@sockaddr_in", Socket.sockaddr_in(3456, "10.10.16.30"))

get '/:guid' do |guid|
  emitter.emit_error(guid, "All your log messages are belong to us. #{guid}")

  "Hello World. This is Mallory."
end