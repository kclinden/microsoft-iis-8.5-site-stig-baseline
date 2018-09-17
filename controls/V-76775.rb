{:id=>"V-76775",
 :title=>"The IIS 8.5 website session state must be enabled.",
 :desc=>
  "When the session information is stored on the client, the session ID, along with the user authorization and identity information, is sent along with each client request and is stored in either a cookie, embedded in the uniform resource locator (URL), or placed in a hidden field on the displayed form. Each of these offers advantages and disadvantages. The biggest disadvantage to all three is the hijacking of a session along with all of the user's credentials.\n" +
  "\n" +
  "When the user authorization and identity information is stored on the server in a protected and encrypted database, the communication between the client and web server will only send the session identifier, and the server can then retrieve user credentials for the session when needed. If, during transmission, the session were to be hijacked, the user's credentials would not be compromised.\n" +
  "\n" +
  "ASP.NET provides a session state, which is available as the HttpSessionState class, as a method of storing session-specific information that is visible only within the session. ASP.NET session state identifies requests from the same browser during a limited time window as a session, and provides the ability to persist variable values for the duration of that session.",
 :impact=>0.7,
 :tests=>[],
 :tags=>
  [{:name=>"gtitle", :value=>"SRG-APP-000001-WSR-000002"},
   {:name=>"gid", :value=>"V-76775"},
   {:name=>"rid", :value=>"SV-91471r1_rule"},
   {:name=>"stig_id", :value=>"IISW-SI-000201"},
   {:name=>"fix_id", :value=>"F-83471r1_fix"},
   {:name=>"cci", :value=>["CCI-000054"]},
   {:name=>"nist", :value=>["AC-10", "Rev_4"]},
   {:name=>"false_negatives", :value=>nil},
   {:name=>"false_positives", :value=>nil},
   {:name=>"documentable", :value=>false},
   {:name=>"mitigations", :value=>nil},
   {:name=>"severity_override_guidance", :value=>false},
   {:name=>"potential_impacts", :value=>nil},
   {:name=>"third_party_tools", :value=>nil},
   {:name=>"mitigation_controls", :value=>nil},
   {:name=>"responsibility", :value=>nil},
   {:name=>"ia_controls", :value=>nil},
   {:name=>"check",
    :value=>
     "Follow the procedures below for each site hosted on the IIS 8.5 web server:\n" +
     "\n" +
     "Open the IIS 8.5 Manager.\n" +
     "\n" +
     "Click the site name.\n" +
     "\n" +
     "Under the \"ASP.NET\" section, select \"Session State\".\n" +
     "\n" +
     "Under \"Session State Mode Settings\", verify the \"In Process\" mode is selected.\n" +
     "\n" +
     "If the \"Session State Mode Settings\" is set to \"In Process\", this is not a finding.\n" +
     "\n" +
     "Alternative method:\n" +
     "\n" +
     "Click the site name.\n" +
     "\n" +
     "Select \"Configuration Editor\" under the \"Management\" section.\n" +
     "\n" +
     "From the \"Section:\" drop-down list at the top of the configuration editor, locate \"system.web/sessionState\".\n" +
     "\n" +
     "Verify the \"mode\" reflects \"InProc\".\n" +
     "\n" +
     "If the \"mode\" is not set to \"InProc\", this is a finding."},
   {:name=>"fix",
    :value=>
     "Follow the procedures below for each site hosted on the IIS 8.5 web server:\n" +
     "\n" +
     "Open the IIS 8.5 Manager.\n" +
     "\n" +
     "Click the site name.\n" +
     "\n" +
     "Under the \"ASP.NET\" section, select \"Session State\".\n" +
     "\n" +
     "Under \"Session State Mode Settings\", verify the \"In Process\" mode is selected.\n" +
     "\n" +
     "Select \"Apply\" from the \"Actions\" pane."}]}
