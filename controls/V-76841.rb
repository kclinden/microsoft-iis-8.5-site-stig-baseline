control 'V-76841' do
  title "The IIS 8.5 websites connectionTimeout setting must be explicitly
  configured to disconnect an idle session."
  desc "Leaving sessions open indefinitely is a major security risk. An
  attacker can easily use an already authenticated session to access the hosted
  application as the previously authenticated user. By closing sessions after a
  set period of inactivity, the web server can make certain that those sessions
  that are not closed through the user logging out of an application are
  eventually closed.

      Acceptable values are 5 minutes for high-value applications, 10 minutes for
  medium-value applications, and 20 minutes for low-value applications.
  "
  impact 0.5
  tag "gtitle": 'SRG-APP-000295-WSR-000134'
  tag "gid": 'V-76841'
  tag "rid": 'SV-91537r2_rule'
  tag "stig_id": 'IISW-SI-000236'
  tag "fix_id": 'F-83537r2_fix'
  tag "cci": ['CCI-002361']
  tag "nist": ['AC-12', 'Rev_4']
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

  Click the site name.

  Select \"Configuration Editor\" under the \"Management\" section.

  From the \"Section:\" drop-down list at the top of the configuration editor,
  locate \"system.web/sessionState\".

  Verify the \"timeout\" is set to \"00:20:00 or less”, using the lowest value
  possible depending upon the application.
  Acceptable values are 5 minutes for high-value applications, 10 minutes for
  medium-value applications, and 20 minutes for low-value applications.

  If \"timeout\" is not set to \"00:20:00 or less”, this is a finding.

  "
  tag "fix": "Follow the procedures below for each site hosted on the IIS 8.5
  web server:

  Open the IIS 8.5 Manager.

  Click the site name.

  Select \"Configuration Editor\" under the \"Management\" section.

  From the \"Section:\" drop-down list at the top of the configuration editor,
  locate \"system.web/sessionState\".

  Set the \"timeout\" to \"00:20:00 or less”, using the lowest value possible
  depending upon the application.
  Acceptable values are 5 minutes for high-value applications, 10 minutes for
  medium-value applications, and 20 minutes for low-value applications.

  In the \"Actions\" pane, click \"Apply\".
  "
  get_names = command("Get-Website | select name | findstr /v 'name ---'").stdout.strip.split("\r\n")
  get_connectionTimeout = command('Get-WebConfigurationProperty -pspath "IIS:\Sites\*" -Filter system.web/sessionState -name * | select -expand timeout | select -expand TotalMinutes').stdout.strip.split("\r\n")

  get_connectionTimeout.zip(get_names).each do |connectionTimeout, names|
    n = names.strip

    describe "The IIS site: #{n} websites connection timeout" do
      subject { connectionTimeout }
      it { should cmp <= 20 }
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
