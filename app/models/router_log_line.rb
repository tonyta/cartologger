class RouterLogLine
  OK_RE = /\sstatus=200\s/
  SUCCESS_RE = /\sstatus=2|3\d\d\s/
  IP_RE = /\sfwd="(\d{1,3}(\.\d{1,3}){3})(,|")/

  def initialize(raw_line)
    @raw_line = raw_line
  end

  def status_ok?
    return @status_ok if defined? @status_ok
    @status_ok = !!(@raw_line =~ OK_RE)
  end

  def status_success?
    return @status_ok if defined? @status_ok
    @status_ok = !!(@raw_line =~ SUCCESS_RE)
  end

  def ip_address
    @ip_address ||= @raw_line[IP_RE, 1]
  end
end
