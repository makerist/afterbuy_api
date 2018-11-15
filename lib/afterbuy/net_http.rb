# Purpose of the Net::HTTP clone: Trying to reproduce the behavior of 'resolv-replace'.
#
# Why not using 'resolv-replace'?
# Requiring it can have side effects. Some http calls cannot succeed with it. Example:
# https://github.com/mperham/sidekiq/issues/1258#issuecomment-27475567
# But we need the resolve logic here as we had dns resolve timeouts while calling the afterbuy api.
#
# As we want to have the 'resolv-replace' behavior only in the afterbuy gem I made a custom TCPSocket according to
# https://github.com/ruby/ruby/blob/trunk/lib/resolv-replace.rb 
# I needed to copy the 'connect' method of Net::HTTP into the custom Afterbuy::NetHttp too that the custom
# TCPSocket is used. In the method I needed to change one line where BufferedIO is used. See below.
#
# Yet I could not find another solution to have this behavior in the afterbuy gem.
# The good thing is: If Net::HTTP#connect is changing dramatically only the afterbuy api is affected. Not the whole app.
# [morten]

module Afterbuy
  class TCPSocket < ::TCPSocket

    alias origin_init initialize

    def initialize(host, serv, *rest)
      rest[0] = Resolv.getaddress(rest[0]).to_s if rest[0]
      origin_init(Resolv.getaddress(host).to_s, serv, *rest)
    end
  end

  class NetHttp < Net::HTTP

    def connect
      if proxy? then
        conn_address = proxy_address
        conn_port    = proxy_port
      else
        conn_address = address
        conn_port    = port
      end

      D "opening connection to #{conn_address}:#{conn_port}..."
      s = Timeout.timeout(@open_timeout, Net::OpenTimeout) {
        begin
          TCPSocket.open(conn_address, conn_port, @local_host, @local_port)
        rescue => e
          raise e, "Failed to open TCP connection to " +
            "#{conn_address}:#{conn_port} (#{e.message})"
        end
      }
      s.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
      D "opened"
      if use_ssl?
        ssl_parameters = Hash.new
        iv_list = instance_variables
        SSL_IVNAMES.each_with_index do |ivname, i|
          if iv_list.include?(ivname) and
            value = instance_variable_get(ivname)
            ssl_parameters[SSL_ATTRIBUTES[i]] = value if value
          end
        end
        @ssl_context = OpenSSL::SSL::SSLContext.new
        @ssl_context.set_params(ssl_parameters)
        D "starting SSL for #{conn_address}:#{conn_port}..."
        s = OpenSSL::SSL::SSLSocket.new(s, @ssl_context)
        s.sync_close = true
        D "SSL established"
      end

      # [morten] prefixed BufferedIO with Net:: as Aferbuy::NetHttp does not know BufferedIO.
      # [morten] Original line:
      # [morten] @socket = BufferedIO.new(s)
      @socket = Net::BufferedIO.new(s) # <<------------------------------------------- changed after copying !! [morten]
      @socket.read_timeout = @read_timeout
      @socket.continue_timeout = @continue_timeout
      @socket.debug_output = @debug_output
      if use_ssl?
        begin
          if proxy?
            buf = "CONNECT #{@address}:#{@port} HTTP/#{HTTPVersion}\r\n"
            buf << "Host: #{@address}:#{@port}\r\n"
            if proxy_user
              credential = ["#{proxy_user}:#{proxy_pass}"].pack('m')
              credential.delete!("\r\n")
              buf << "Proxy-Authorization: Basic #{credential}\r\n"
            end
            buf << "\r\n"
            @socket.write(buf)
            HTTPResponse.read_new(@socket).value
          end
          # Server Name Indication (SNI) RFC 3546
          s.hostname = @address if s.respond_to? :hostname=
          if @ssl_session and
             Process.clock_gettime(Process::CLOCK_REALTIME) < @ssl_session.time.to_f + @ssl_session.timeout
            s.session = @ssl_session if @ssl_session
          end
          if timeout = @open_timeout
            while true
              raise Net::OpenTimeout if timeout <= 0
              start = Process.clock_gettime Process::CLOCK_MONOTONIC
              # to_io is required because SSLSocket doesn't have wait_readable yet
              case s.connect_nonblock(exception: false)
              when :wait_readable; s.to_io.wait_readable(timeout)
              when :wait_writable; s.to_io.wait_writable(timeout)
              else; break
              end
              timeout -= Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
            end
          else
            s.connect
          end
          if @ssl_context.verify_mode != OpenSSL::SSL::VERIFY_NONE
            s.post_connection_check(@address)
          end
          @ssl_session = s.session
        rescue => exception
          D "Conn close because of connect error #{exception}"
          @socket.close if @socket and not @socket.closed?
          raise exception
        end
      end
      on_connect
    end
    private :connect

  end
end
