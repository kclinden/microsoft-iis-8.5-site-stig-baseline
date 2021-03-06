control 'V-76879' do
  title "The application pools rapid fail protection for each IIS 8.5 website
  must be enabled."
  desc "Rapid fail protection is a feature that interrogates the health of
  worker processes associated with websites and web applications. It can be
  configured to perform a number of actions such as shutting down and restarting
  worker processes that have reached failure thresholds. By not setting rapid
  fail protection the web server could become unstable in the event of a worker
  process crash potentially leaving the web server unusable."
  impact 0.5
  tag "gtitle": 'SRG-APP-000516-WSR-000174'
  tag "gid": 'V-76879'
  tag "rid": 'SV-91575r1_rule'
  tag "stig_id": 'IISW-SI-000258'
  tag "fix_id": 'F-83575r1_fix'
  tag "cci": ['CCI-000366']
  tag "nist": ['CM-6 b', 'Rev_4']
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
  tag "check": "Open the IIS 8.5 Manager.

  Click the Application Pools.

  Perform for each Application Pool.

  Highlight an Application Pool to review and click \"Advanced Settings\" in the
  \"Actions\" pane.

  Scroll down to the \"Rapid Fail Protection\" section and verify the value for
  \"Enabled\" is set to \"True\".

  If the \"Rapid Fail Protection:Enabled\" is not set to \"True\", this is a
  finding."
  tag "fix": "Open the IIS 8.5 Manager.

  Click the Application Pools.

  Perform for each Application Pool.

  Highlight an Application Pool to review and click \"Advanced Settings\" in the
  \"Actions\" pane.

  Scroll down to the \"Rapid Fail Protection\" section and set the value for
  \"Enabled\" to \"True\".

  Click OK."

  application_pool_names = json(command: 'ConvertTo-Json @(Get-ChildItem -Path IIS:\AppPools | select -expand name)').params

  application_pool_names.each do |application_pool|
    iis_configuration = json(command: "Get-ItemProperty 'IIS:\\AppPools\\#{application_pool}' -name * | select -expand failure | ConvertTo-Json")

    describe "The rapid fail protection setting for IIS Application Pool :'#{application_pool}'" do
      subject { iis_configuration }
      its('rapidFailProtection') { should cmp 'True' }
    end
  end
  if application_pool_names.empty?
    impact 0.0
    desc 'There are no application pool configured hence the control is Not-Applicable'

    describe 'No application pool where found to be reviewed' do
      skip 'No application pool where found to be reviewed'
    end
  end
end
