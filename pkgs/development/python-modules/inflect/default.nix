{
  lib,
  buildPythonPackage,
  fetchPypi,
  isPy27,
  more-itertools,
  setuptools-scm,
  pydantic,
  pytestCheckHook,
  typeguard,
}:

buildPythonPackage rec {
  pname = "inflect";
  version = "7.2.1";
  disabled = isPy27;
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-p85eI9Z5hzTyVsGtntUhhrjsJ28QsYzj0+yxnCHrbLY=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [
    more-itertools
    pydantic
    typeguard
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTests = [
    # https://errors.pydantic.dev/2.5/v/string_too_short
    "inflect.engine.compare"
  ];

  pythonImportsCheck = [ "inflect" ];

  meta = with lib; {
    description = "Correctly generate plurals, singular nouns, ordinals, indefinite articles";
    homepage = "https://github.com/jaraco/inflect";
    changelog = "https://github.com/jaraco/inflect/blob/v${version}/CHANGES.rst";
    license = licenses.mit;
    maintainers = teams.tts.members;
  };
}
