class V2rayCore < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://www.v2ray.com/"
  url "https://github.com/v2ray/v2ray-core/releases/download/v3.32/v2ray-macos.zip"
  version "v3.32"
  sha256 "93e0fa7a329fb0be29a194ce9567f152d5679ea29db8dda25275c63dfc566fe6"

  def install
    etc.install "config.json"

    rm_f Dir["config.json"]
    prefix.install Dir["output/*"]

  end

  plist_options :manual => "v2ray -config=#{HOMEBREW_PREFIX}/etc/config.json"

  def plist; <<~EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{prefix}/v2ray</string>
        <string>-config</string>
        <string>#{etc}/config.json</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
  </plist>
  EOS
end
  
  test do
    system "#{prefix}/v2ray", "-version"
  end
end
