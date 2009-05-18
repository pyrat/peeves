module Peeves
  class ProtxCallback < ProtxResponse
    def initialize(response)
      @response = response
      if @response.is_a?(String)
        response.split("&").each do |line|
          key, *value = line.split("=")
          value = value.join("=")
          self[key] = value
        end
      elsif @response.is_a?(Hash)
        response.each do |key, value|
          self[key] = value
        end
      else
        raise Peeves::Error, "Cannot parse response of type #{@response.class}"
      end
    end
    
    def failed?
      PeevesGateway::FAILURES.include?(self.status)
    end
    
    def error?
      self.status = PeevesGateway::ERROR
    end
    
  end
end
