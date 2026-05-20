{ buildPythonApplication, fetchPypi, boto3, pyjwt, click, requests }:

buildPythonApplication rec {
  pname = "auth0-login";
  version = "0.5.2";
  src = fetchPypi {
    inherit pname version;
    sha256 = "01wjzjxqb0qxzbdran95rp74jib9cbcr5g0z67xb2f71xqqcm8k5"; 
  };
  propagatedBuildInputs = [boto3 pyjwt click requests];
  doCheck = false;
}
