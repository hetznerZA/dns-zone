# `A` resource record.
#
# RFC 1035
class DNS::Zone::RR::TXT < DNS::Zone::RR::Record

  attr_accessor :text

  def dump
    parts = general_prefix
    parts << text
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    # extract text from within quotes; allow multiple quoted strings; ignore escaped quotes
    # @text = rdata.scan(/"#{DNS::Zone::RR::REGEX_STRING}"/).flatten.map { |w| %Q{"#{w}"} }.join
    @text = rdata.scan(/"#{DNS::Zone::RR::REGEX_STRING}"/).flat_map { |w| %Q{"#{w&.first}"} }.join(' ')
    self
  end

end
