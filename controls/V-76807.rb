control 'V-76807' do
  title 'Each IIS 8.5 website must be assigned a default host header.'
  desc "The web server must be configured to listen on a specified IP address
  and port. Without specifying an IP address and port for the web server to
  utilize, the web server will listen on all IP addresses available to the
  hosting server. If the web server has multiple IP addresses, i.e., a management
  IP address, the web server will also accept connections on the management IP
  address.

      Accessing the hosted application through an IP address normally used for
  non-application functions opens the possibility of user access to resources,
  utilities, files, ports, and protocols that are protected on the desired
  application IP address.
  "
  impact 0.5
  tag "gtitle": 'SRG-APP-000142-WSR-000089'
  tag "gid": 'V-76807'
  tag "rid": 'SV-91503r1_rule'
  tag "stig_id": 'IISW-SI-000219'
  tag "fix_id": 'F-83503r1_fix'
  tag "cci": ['CCI-000382']
  tag "nist": ['CM-7 b', 'Rev_4']
  tag "false_negatives": nil
  tag "false_positives": nil
  tag "documentable": false
  tag "mitigations": nil
  tag "severity_override_guidance": false
  tag "potential_impacts": nil
  tag "third_party_tools": nil
  tag "mitigation_controls": nil
  tag "responsibility": nil
  tag "ia_controls": nil
  tag "check": "Follow the procedures below for each site hosted on the IIS 8.5
  web server:

  Open the IIS 8.5 Manager.

  Right-click on the site name under review.

  Select Edit Bindings.

  Verify there are hostname entries and unique IP addresses assigned to port 80
  for HTTP and port 443 for HTTPS.

  If both hostname entries and unique IP addresses are not configure to port 80
  for HTTP and port 443 for HTTPS, this is a finding."
  tag "fix": "Follow the procedures below for each site hosted on the IIS 8.5
  web server:

  Open the IIS 8.5 Manager.

  Right-click on the site name under review.

  Select Edit Bindings.

  Assign hostname entries and unique IP addresses to port 80 for HTTP and port
  443 for HTTPS.

  Click \"OK\".

  Select \"Apply\" from the \"Actions\" pane."

  site_name = attribute('site_name')

  http_ip = attribute('http_ip')

  http_hostname = attribute('http_hostname')

  https_ip = attribute('https_ip')

  https_hostname = attribute('https_hostname')

  site_name.zip(http_ip, http_hostname).each do |site, httpip, httphostname|
    describe iis_site(site.to_s) do
      it { should exist }
      it { should have_binding("http #{httpip}:80:#{httphostname}") }
    end
  end
  site_name.zip(https_ip, https_hostname).each do |site, httpsip, httsphostname|
    describe iis_site(site.to_s) do
      it { should exist }
      it { should have_binding("https #{httpsip}:80:#{httsphostname}") }
    end
  end
end
