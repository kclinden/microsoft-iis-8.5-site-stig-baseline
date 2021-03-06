control 'V-76827' do
  title "Unlisted file extensions in URL requests must be filtered by any IIS
  8.5 website."
  desc "Request filtering enables administrators to create a more granular
  rule set to allow or reject inbound web content. By setting limits on web
  requests it helps to ensure availability of web services and may also help
  mitigate the risk of buffer overflow type attacks. The allow unlisted property
  of the “File Extensions Request” filter enables rejection of requests
  containing specific file extensions not defined in the “File Extensions”
  filter. Tripping this filter will cause IIS to generate a Status Code 404.7."
  impact 0.5
  tag "gtitle": 'SRG-APP-000246-WSR-000149'
  tag "gid": 'V-76827'
  tag "rid": 'SV-91523r1_rule'
  tag "stig_id": 'IISW-SI-000230'
  tag "fix_id": 'F-83523r1_fix'
  tag "cci": ['CCI-001094']
  tag "nist": ['SC-5 (1)', 'Rev_4']
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

  Click on the site name.

  Double-click the \"Request Filtering\" icon.

  Click Edit Feature Settings in the \"Actions\" pane.

  If \"Allow unlisted file name extensions\" check box is checked, this is a

  finding."
  tag "fix": "Follow the procedures below for each site hosted on the IIS 8.5
  web server:

  Open the IIS 8.5 Manager.

  Click the site name under review.

  Double-click the \"Request Filtering\" icon.

  Click Edit Feature Settings in the \"Actions\" pane.

  Uncheck the \"Allow unlisted file extensions\" check box."

  get_names = command("Get-Website | select name | findstr /v 'name ---'").stdout.strip.split("\r\n")
  get_allow_unlisted = command('Get-WebConfigurationProperty -pspath "IIS:\Sites\*" -Filter system.webServer/security/requestFiltering -name * | select -expand fileExtensions | select -expand allowUnlisted').stdout.strip.split("\r\n")

  get_allow_unlisted.zip(get_names).each do |allow_unlisted, names|
    n = names.strip

    describe "The IIS site: #{n} websites Allow unlisted file extension" do
      subject { allow_unlisted }
      it { should cmp 'False' }
    end
  end
  if get_names.empty?
    impact 0.0
    desc 'There are no IIS sites configured hence the control is Not-Applicable'

    describe 'No sites where found to be reviewed' do
      skip 'No sites where found to be reviewed'
    end
  end
end
